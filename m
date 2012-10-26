From: James Nylen <jnylen@gmail.com>
Subject: Re: Subtree in Git
Date: Fri, 26 Oct 2012 12:54:06 -0400
Message-ID: <CABVa4Ng9=Q9YSwU-CQNyQXQOHVKOWz5eK+G8sBiXk4HS=BksiA@mail.gmail.com>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com>
	<nngk410vrja.fsf@transit.us.cray.com>
	<4F9FA029.7040201@initfour.nl>
	<87fwbgbs0h.fsf@smith.obbligato.org>
	<7v8vh78dag.fsf@alter.siamese.dyndns.org>
	<4FA82799.1020400@initfour.nl>
	<nngzk9jvemb.fsf@transit.us.cray.com>
	<nngaa0z3p8b.fsf@transit.us.cray.com>
	<87bokpxqoq.fsf@smith.obbligato.org>
	<4FD89383.70003@initfour.nl>
	<nng4npe6zsj.fsf@transit.us.cray.com>
	<50830374.9090308@initfour.nl>
	<7vbofwgwso.fsf@alter.siamese.dyndns.org>
	<5084102A.2010006@initfour.nl>
	<nnga9vefu1v.fsf@transit.us.cray.com>
	<508A8BD3.9020901@initfour.nl>
	<2DDAA35052EA4F88A6EAC4FBDDF7FCCD@rr-dav.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Herman van Rink <rink@initfour.nl>, dag@cray.com,
	Junio C Hamano <gitster@pobox.com>, greened@obbligato.org,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: David Michael Barr <b@rr-dav.id.au>
X-From: git-owner@vger.kernel.org Fri Oct 26 18:54:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRnAr-0006Cn-BJ
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 18:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370Ab2JZQyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 12:54:08 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45031 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254Ab2JZQyH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 12:54:07 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so4033099iea.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 09:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QAlxlCldgPrC8Br/tg7TYtvtrFT3ENMlhiLL+HlvN6M=;
        b=X4/rHxR/tnCHffi1cYh5LiTymVCsssOK2rrdDvlUuLCQUTwRtAzekHiBp6ZzWI4S5N
         zDWFBzN2K/0pvPTevxzEC9Q7P+lu0iF1wvw7kkMVoy8SKA3P2DlGsta5Hp8kpPMCdnaY
         4ZTVHzb5LPF/Uc4IJEZ2t63cJBTpR6cI89dkxSu8AYWADrCMKVHux1qC36ICpga1CWzX
         GHO9t5/KKKoMKTCRJWrkL7xMir5Cju2YGkuJDYBtr4SHi4nB4XzC/7397T9gyMRo4D7E
         JE+qQG6rdB9JTVIlZNk+we0CMkkaa3EDTC/AAFj5uvY+c94lbRE5qVkbZ78MrhQtTPv7
         yVMg==
Received: by 10.43.92.71 with SMTP id bp7mr19950909icc.29.1351270446534; Fri,
 26 Oct 2012 09:54:06 -0700 (PDT)
Received: by 10.42.173.130 with HTTP; Fri, 26 Oct 2012 09:54:06 -0700 (PDT)
In-Reply-To: <2DDAA35052EA4F88A6EAC4FBDDF7FCCD@rr-dav.id.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208465>

On Fri, Oct 26, 2012 at 9:58 AM, David Michael Barr <b@rr-dav.id.au> wrote:
> From a quick survey, it appears there are no more than 55 patches
> squashed into the submitted patch.
> As I have an interest in git-subtree for maintaining the out-of-tree
> version of vcs-svn/ and a desire to improve my rebase-fu, I am tempted
> to make some sense of the organic growth that happened on GitHub.
> It doesn't appear that anyone else is willing to do this, so I doubt
> there will be any duplication of effort.

David, I think that would be great.  I wish I had time to work on
unwrapping the current patch but I don't.  I will definitely re-submit
my (simple) patch after this is done though.
