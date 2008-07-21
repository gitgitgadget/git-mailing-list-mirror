From: "=?ISO-8859-1?Q?Steve_Fr=E9cinaux?=" <nudrema@gmail.com>
Subject: Re: [PATCH] Documentation/git-ls-tree.txt: Add a caveat about prefixing pathspec
Date: Mon, 21 Jul 2008 10:45:52 +0200
Message-ID: <f35478f50807210145r6a6fced3n2a7047f00d44b4d3@mail.gmail.com>
References: <20080720233956.GH10151@machine.or.cz>
	 <20080721075618.14163.45309.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jul 21 10:46:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKr2j-00063m-QN
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 10:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755774AbYGUIpy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jul 2008 04:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755431AbYGUIpx
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 04:45:53 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:12031 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755371AbYGUIpx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jul 2008 04:45:53 -0400
Received: by an-out-0708.google.com with SMTP id d40so353022and.103
        for <git@vger.kernel.org>; Mon, 21 Jul 2008 01:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ghEDK3pOEgoqjwpFJvcpPLAnVkpcHgOsv8i6zNj+k/w=;
        b=WTtYpLHHy78BvjjbCkvR0k+SSFCScrMe3BYR2u67m6ne8MLHpUDoOt0/Bw7vSchYyw
         qidrjaBfl2QZb/lkXCBQRKFGPohxDzDd5zbG31AMwZhXuJwPz1AniXnO3JjW6JPUmanz
         m21S4Zu2Ub9qsuhvYEcWXlu/L5ATvS6JROaY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Y/tXden9kcoweUQAi3g3BhSHEBgjGdHU5Ge7EJqLT4ZYPJMwyGvHAizeCl5kd0W6BU
         gLj+ReXCufpr0TWrH7Ti2iz828oEv6oNcItfSvu2wHMZTwMOyzye/quMPudqMD7r9VwV
         u2DA5IfSbTN6ytlRnhC2r3tQh0471tVOHgdvQ=
Received: by 10.100.154.9 with SMTP id b9mr1623445ane.78.1216629952094;
        Mon, 21 Jul 2008 01:45:52 -0700 (PDT)
Received: by 10.100.250.10 with HTTP; Mon, 21 Jul 2008 01:45:52 -0700 (PDT)
In-Reply-To: <20080721075618.14163.45309.stgit@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89324>

On Mon, Jul 21, 2008 at 9:56 AM, Petr Baudis <pasky@suse.cz> wrote:
> This was originally pointed out and described in a patch by
> Steve Fr=E9naux <code@istique.net>, this is a shot at clearer and mor=
e
> accurate description.

There is a typo in my name ;-)
