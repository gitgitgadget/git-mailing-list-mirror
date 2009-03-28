From: jamespetts <jamespetts@yahoo.com>
Subject: Re: Fork of abandoned SVN mirror - how to keep up to date with the
  SVN
Date: Sat, 28 Mar 2009 11:06:20 -0700 (PDT)
Message-ID: <1238263580197-2549943.post@n2.nabble.com>
References: <22756729.post@talk.nabble.com> <8c9a060903280922r6514de83mea4dea84c4116225@mail.gmail.com> <1238258794470-2549665.post@n2.nabble.com> <8c9a060903281102r3eae26edta34899485feb884b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 28 19:08:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lncwj-00042S-1e
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 19:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392AbZC1SGW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Mar 2009 14:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753312AbZC1SGW
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 14:06:22 -0400
Received: from kuber.nabble.com ([216.139.236.158]:39507 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116AbZC1SGW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Mar 2009 14:06:22 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1LncvE-0003HY-6V
	for git@vger.kernel.org; Sat, 28 Mar 2009 11:06:20 -0700
In-Reply-To: <8c9a060903281102r3eae26edta34899485feb884b@mail.gmail.com>
X-Nabble-From: jamespetts@yahoo.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114974>


Thank you very much for your reply :-) Ahh, I didn't realise that that =
sort of SVN URL should be avoided. Is there any way around that when th=
e project itself uses that sort of URL? And I think that it does requir=
e a username and empty password. I haven't tried the Github IRC channel=
 - I must confess - I did not know that there was one.=20

Any suggestions about how to deal with the other problem?



The GitHub "Import a Subversion Repository" page does mention that you
should try to avoid "svn://example.com/project/svn" style URLs (which
SimuTrans uses).  Maybe it's having trouble with needing a username &
empty password?

Unfortunately, I've never actually used the "Import from SVN" on
GitHub.  I see you've already posted to http://support.github.com/
about this.  Have you tried asking in the GitHub IRC channel?

On Sat, Mar 28, 2009 at 09:46, jamespetts <jamespetts@yahoo.com> wrote:
>
>
>
> I just tried cloning this repo using the command below, and it appear=
s
> to be working just fine. (Hasn't finished, yet. =C2=A0Up to rev 465.)=
 =C2=A0What
> is the full command you're using when it will hang?
>
> I was not using the command line - I was using the GUI on the Github =
website.
> --
> View this message in context: http://n2.nabble.com/Fork-of-abandoned-=
SVN-mirror---how-to-keep-up-to-date-with-the-SVN-tp2548952p2549665.html
> Sent from the git mailing list archive at Nabble.com.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe git" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
View this message in context: http://n2.nabble.com/Fork-of-abandoned-SV=
N-mirror---how-to-keep-up-to-date-with-the-SVN-tp2548952p2549943.html
Sent from the git mailing list archive at Nabble.com.
