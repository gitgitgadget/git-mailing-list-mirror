From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 18:35:22 +1300
Message-ID: <46a038f90710142235i6d7e39c4qdb5d33941352e1aa@mail.gmail.com>
References: <1192293466.17584.95.camel@homebase.localnet>
	 <uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet>
	 <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
	 <Pine.LNX.4.64.0710141916510.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Benoit SIGOURE" <tsuna@lrde.epita.fr>,
	"git list" <git@vger.kernel.org>, "Eli Zaretskii" <eliz@gnu.org>,
	"Make Windows" <make-w32@gnu.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 15 07:35:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhIc5-0001Ia-HB
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 07:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbXJOFf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 01:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbXJOFf0
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 01:35:26 -0400
Received: from hu-out-0506.google.com ([72.14.214.227]:3030 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbXJOFfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 01:35:25 -0400
Received: by hu-out-0506.google.com with SMTP id 19so1189790hue
        for <git@vger.kernel.org>; Sun, 14 Oct 2007 22:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=EEPvMVnq4Oq0477uci3BaxorxMObdkIfjGZr8tKJPlU=;
        b=ZnHsZgu+z26CIcZA8I5/q3aba9yCPJDMUAsfwxAZi5dDY7OEZ3SVOE/7yawC+iNtrMGwCIEGgz+dNlbbPJZeunfIt0yVSo7QyhLrW+RyVMdshN/AcbiniF1dhAc/m4CY+/cui9QajJ8u3raeAb2LTGr4FaQ8dR3X8K4KO3hcihM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZLKdD2Gj8eq6EJIcjlappS5YdeBPiqVFIQa68XcdEQTnwx7aNwADIsjzvjm4fg/wFefFqwn62cW/67zjYu+cB0c+lB+381n7ByorXecbiqtm8ITen4CK2cOr0uNaU4Evv9szIpewB0Dr2WgCnJkiY53qa1oAG8bjfoxlCfnaFUU=
Received: by 10.66.252.8 with SMTP id z8mr7500368ugh.1192426522485;
        Sun, 14 Oct 2007 22:35:22 -0700 (PDT)
Received: by 10.67.22.19 with HTTP; Sun, 14 Oct 2007 22:35:22 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710141916510.25221@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60945>

On 10/15/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> There is msysGit.  This project is nearing to its first beta, being
> self-hosted since mid-August IIRC.

I've been using it recently, I have to say it's pretty impressive -
you can use it from cmd.com or from a bash window (courtesy of the
msys environment included). The GUIs that ship with git are there
(git-gui, gitk).

I use gitk extensively, and it works *great*. My work-style is of a
shell window for status/diff/commit actions and one or more gitk
windows for browsing of proj history. You can use git-gui for a visual
status/git/commit workflow, or qgit. qgit is more integrated, and
might feel more "at home" for users that expect something more
MDI-ish.

cheers.


martin
