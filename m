From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Feature idea: Ignore content
Date: Wed, 20 Jan 2010 00:54:23 +0530
Message-ID: <f3271551001191124s3f6b97f2te6ca8f3e9a9b1b9d@mail.gmail.com>
References: <f3271551001190529h389ce321k52dcca6b03e4e8f0@mail.gmail.com> 
	<alpine.DEB.2.00.1001191504020.23165@ds9.cixit.se> <4B56049C.6070705@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Tue Jan 19 20:24:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXJh7-00025s-GH
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 20:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525Ab0ASTYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 14:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730Ab0ASTYs
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 14:24:48 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:53350 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab0ASTYr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 14:24:47 -0500
Received: by ywh12 with SMTP id 12so2781342ywh.21
        for <git@vger.kernel.org>; Tue, 19 Jan 2010 11:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=45FsBOK+X+qC/weL8E3gB8ja7MNRyygccqEBI+C2TFA=;
        b=tlvQU/4vgsIZJi2bX4Fwb2LL98Ikk9WD0zLGKCficB2H34Kov+XFa+C8p7H8mGiWcM
         G6A/pQ58La1pMvH3esq460DPMzpLADI5xKVvhSDFiBXwlTFGHC+3j+cr8gDpeYoYelQf
         X0LNYwY8FM9bExVwnDvo4meKrHx5hL4LP7+W4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=J88HwcNdoMxUXGJGTlcpchgi/kOnp7SXEWTVOuu0mT0tCRNq2Dxa1fpgzrJiuVhkKh
         DY55RSQReYZd0YGUIfgLHTSJKrsuC8MUTW+05Cy2zGOTUt0KAk70qz6+HlH7UCornf+q
         RLTJ9EVgjMY3Pl1+YXAdyQFvELMNTkzjuHgHM=
Received: by 10.90.16.12 with SMTP id 12mr7387359agp.46.1263929083382; Tue, 19 
	Jan 2010 11:24:43 -0800 (PST)
In-Reply-To: <4B56049C.6070705@dirk.my1.cc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137490>

> http://marc.info/?t=125882165900001&r=1&w=2

Fantastic- I had no idea that such a feature even existed. I got it to
work nicely. Thanks!
