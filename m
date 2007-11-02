From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Implement git commit as a builtin command.
Date: Fri, 2 Nov 2007 10:27:20 +0100
Message-ID: <20071102092720.GA30468@diana.vm.bytemark.co.uk>
References: <1193944163-22892-1-git-send-email-krh@redhat.com> <fgdc3m$miq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 10:27:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Insod-0000v6-9s
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 10:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbXKBJ1d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Nov 2007 05:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752627AbXKBJ1d
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 05:27:33 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2467 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbXKBJ1c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 05:27:32 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1InsoC-0008AA-00; Fri, 02 Nov 2007 09:27:20 +0000
Content-Disposition: inline
In-Reply-To: <fgdc3m$miq$1@ger.gmane.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63083>

On 2007-11-01 21:14:45 +0100, Jakub Narebski wrote:

> Kristian H?gsberg wrote:
>
> > Move git-commit.sh to contrib/examples.
>
> Just a note: you might want to use "git format-patch -M".

I wonder if it would be such a bad idea to make this the default. It
seems like _everyone_ who should be using it forget it. And the number
of patches made for human or git consumption is probably vastly larger
than the number of patches made for consumption by other tools.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
