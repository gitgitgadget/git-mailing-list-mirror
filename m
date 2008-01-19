From: =?iso-8859-1?Q?Fran=E7ois?= Pinard <pinard@iro.umontreal.ca>
Subject: Tiny bug report, interaction between alias and help
Date: Sat, 19 Jan 2008 09:27:50 -0500
Message-ID: <20080119142750.GA9182@phenix.progiciels-bpi.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 19 15:40:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGErk-0003AD-Fh
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 15:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbYASOjm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2008 09:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbYASOjm
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 09:39:42 -0500
Received: from 206-248-137-202.dsl.teksavvy.com ([206.248.137.202]:51909 "EHLO
	phenix.progiciels-bpi.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278AbYASOjm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 09:39:42 -0500
X-Greylist: delayed 710 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Jan 2008 09:39:42 EST
Received: by phenix.progiciels-bpi.ca (Postfix, from userid 2001)
	id 4482A970A1; Sat, 19 Jan 2008 09:27:49 -0500 (EST)
Mail-Followup-To: =?iso-8859-1?Q?Fran=E7ois?= Pinard <pinard@iro.umontreal.ca>,
	git mailing list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71107>

Hi, git people.  (My first message here, please be kind!)

Page http://git.or.cz/#community says to report git bugs on this list.
This is a tiny bug for "git version 1.5.4.rc3.14.g44397-dirty".  If the
"bug" is inappropriate, please then consider this as a suggestion!  :-)

If, after "git config --global alias.st status", say, I try:

   git st --help

git then replies:

   No manual entry for git-st

It would be nice if --help was interacting better with aliases.

                                       Thanks for your attention,

--=20
=46ran=E7ois Pinard   http://pinard.progiciels-bpi.ca
