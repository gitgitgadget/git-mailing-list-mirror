From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] CodingGuidelines: Fix a typo
Date: Mon, 11 Oct 2010 01:44:04 -0500
Message-ID: <20101011064404.GB32034@burratino>
References: <1286623119-13766-1-git-send-email-stepnem@gmail.com>
 <20101009152758.GA17799@burratino>
 <7v39sfuue3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stepnem@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 08:49:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5CCK-00005r-Lo
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 08:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497Ab0JKGrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 02:47:20 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40193 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364Ab0JKGrT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 02:47:19 -0400
Received: by iwn6 with SMTP id 6so2959975iwn.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 23:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=eMSSUJVN5SdxseD+GIDACAJLtiFXkYUTpdRppEB4reQ=;
        b=ooVwcLFV0tPgvKM4XJ2sGzLe8fHSX2oWyJXCVzs7WteG9oKbVgli0wlKE2Xzlq5V04
         rhOPVlGg26sYlQnRyOtHgHafxdhw8xhvKCbRh+ia6276o3GXVi7JHu0luHwKvCJ05gsU
         Sy5r2pEUTsgSF2he3v16Nunb3vTW/EtwlvZ78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=A6mqHwqJdwDLjAA/VL98dyO7Gc9GKM1p0KABymUuYMMXRSc97izzPYHyLske+hUA8O
         6wpG2NHnT0PPZEp42mdGQ0a/Al5BSlGweZNUweKFrYqUkDi8LbIlo4PgL/vpw1eye8x8
         me+cwFg1ZGIAoJvJLy9uX5wnJTVTePpprUThU=
Received: by 10.42.16.67 with SMTP id o3mr1722492ica.184.1286779638722;
        Sun, 10 Oct 2010 23:47:18 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id d40sm4713745ibc.7.2010.10.10.23.47.17
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 23:47:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v39sfuue3.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158751>

Junio C Hamano wrote:

> I had the same reaction.  Perhaps moving other parameter substitions
> closer to these two would help?

Yes, that looks like a definite improvement.
