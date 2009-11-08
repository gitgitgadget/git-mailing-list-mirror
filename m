From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: gitk : french translation
Date: Sun, 08 Nov 2009 13:33:47 +0100
Message-ID: <vpqtyx5nql0.fsf@bauges.imag.fr>
References: <9f50533b0911060605p6ad28ad9neac3620a1809c3db@mail.gmail.com>
	<b0c32d010911061016t2208af0er8d7fe88508c30f10@mail.gmail.com>
	<9f50533b0911061259w54b57fcdo2c0b21e95dbbdc54@mail.gmail.com>
	<20091107025439.GC13724@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Emmanuel Trillaud <etrillaud@gmail.com>,
	Thomas Moulard <thomas.moulard@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Sun Nov 08 13:34:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N76y1-0008Cj-Gi
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 13:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124AbZKHMdu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Nov 2009 07:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753961AbZKHMdu
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 07:33:50 -0500
Received: from mx2.imag.fr ([129.88.30.17]:51869 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753956AbZKHMdt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 07:33:49 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id nA8CWu0q027998
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 8 Nov 2009 13:32:56 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1N76xn-0001zN-Fm; Sun, 08 Nov 2009 13:33:47 +0100
In-Reply-To: <20091107025439.GC13724@vidovic> (Nicolas Sebrecht's message of "Sat\, 7 Nov 2009 03\:54\:39 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 08 Nov 2009 13:32:56 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nA8CWu0q027998
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1258288377.58839@0qctCgbrqP3ECsO5BvL14A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132395>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

>> > - make some consistency changes
>> > =A0* s/diff/diff=E9rences/
>> > =A0* s/patch/correctif/ everywhere
>
> I disagree here. Words like "diff", "commit", "patch", etc should be
> kept as is. Translation of those terms make things harder for the use=
rs.

Metoo.

One day or another, the user will have to face the words "diff",
"commit" and "patch" even in a 100% french-speaking context (for
example when requesting help and someone answering "open a terminal
and type 'git commit --whatever'" or so).

Matching the command-line concepts and the GUI concepts is made really
hard by over-translating.

(and BTW, "correctif" is not a very good translation of "patch", since
a patch is not necessarilly a correction of something).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
