From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation: convert "diffcore" and "repository-layout" to man pages
Date: Sun, 4 May 2008 19:13:52 +0200
Message-ID: <200805041913.54900.jnareb@gmail.com>
References: <20080504183433.baf3058e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio Hamano <junkio@cox.net>, Pieter de Bie <pdebie@ai.rug.nl>,
	Manoj Srivastava <srivasta@ieee.org>,
	"Thomas Adam" <thomas.adam22@gmail.com>, Jeff King <peff@peff.net>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun May 04 19:14:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JshnY-0003EZ-TJ
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 19:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbYEDROF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 May 2008 13:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbYEDROE
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 13:14:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:36588 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbYEDROC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 13:14:02 -0400
Received: by nf-out-0910.google.com with SMTP id d3so960432nfc.21
        for <git@vger.kernel.org>; Sun, 04 May 2008 10:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=6FwB+ltibicb0KMK1nlXKEjQgvOrDhtFPT/ZW2/kfDc=;
        b=xdZHyguew7WcaoZ1LBZ8MSk/toy5Ds5A3Ie0jBz47ikQ0bBmdsEs64YCckbtXseIHz6QZO+XoO3xJF1xO/Ewy4ZH3CUAr2KKu99cmTT/RwfuMfD89o23KcTZpWc+IzF+la95IDKRJABn9K99/kf/rSk44gD4WOXk7vdWoVStabc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=eiFo9f8yfMzOCc/kMHQOVfWGqmcOSqScy6Nnjd2HCwWaVASlOkx44AtcWZ8zrskLv2OnXcg0noFlnM24yajizVPjxFBM18fag5Mx3kEEeXEnn8Ny5IdA2M/eQ973gSxJo6AE67ZeYhzCHLdQRHks+gihrLE3/coEYB+WqAhFHo0=
Received: by 10.210.34.2 with SMTP id h2mr4844673ebh.122.1209921240942;
        Sun, 04 May 2008 10:14:00 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.224.254])
        by mx.google.com with ESMTPS id y37sm9664654iky.8.2008.05.04.10.13.56
        (version=SSLv3 cipher=OTHER);
        Sun, 04 May 2008 10:13:59 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080504183433.baf3058e.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81189>

On Sun, 4 May 2008, Christian Couder wrote:

> This patch renames the following documents and at the same time conve=
rts
> them to the man format:
>=20
> difcore.txt =A0 =A0 =A0 =A0 =A0 -> gitdiffcore.txt
> repository-layout.txt -> gitrepository-layout.txt

I'd rather use git-repository-layout.txt

--=20
Jakub Narebski
Poland
