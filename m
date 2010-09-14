From: Thomas Dickey <dickey@his.com>
Subject: Re: git diffstat feature suggestion
Date: Mon, 13 Sep 2010 17:33:41 -0700 (PDT)
Message-ID: <d8b9a7c5-ee78-4b75-a820-8eb8943c9f13@g18g2000vbn.googlegroups.com>
References: <AANLkTimr6MByE=jnKAjku1Hbcm66giHMLNz6TVxxkYkq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 03:21:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvKDH-0000Jf-MA
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 03:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859Ab0INBVR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 21:21:17 -0400
Received: from mail-gy0-f184.google.com ([209.85.160.184]:43299 "EHLO
	mail-gy0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650Ab0INBVR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Sep 2010 21:21:17 -0400
X-Greylist: delayed 2854 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Sep 2010 21:21:17 EDT
Received: by gyg8 with SMTP id 8so4149371gyg.1
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 18:21:16 -0700 (PDT)
Received: by 10.101.52.7 with SMTP id e7mr147015ank.49.1284424421848; Mon, 13
 Sep 2010 17:33:41 -0700 (PDT)
Received: by g18g2000vbn.googlegroups.com with HTTP; Mon, 13 Sep 2010 17:33:41
 -0700 (PDT)
In-Reply-To: <AANLkTimr6MByE=jnKAjku1Hbcm66giHMLNz6TVxxkYkq@mail.gmail.com>
X-IP: 96.255.37.241
User-Agent: G2/1.0
X-HTTP-UserAgent: Opera/9.80 (X11; Linux i686; U; en) Presto/2.2.15 Version/10.10,gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156157>

On Sep 11, 4:35=A0pm, Marc Bejarano <b...@beej.org> wrote:
> hi.
>
> i find the diffstats that get posted to development mailing lists fro=
m
> people using (i'm guessing) quilt to be great. one improvement that
> comes to mind would be some sort of option that just tallies changes
> in actual lines of code, ignoring whitespace and comments.

fwiw, I don't recall seeing any patches from quilt (I don't use it).

To track whitespace and comments, it would of course be necessary to
make the diff program know about various program's syntaxes.
