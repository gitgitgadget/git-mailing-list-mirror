From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: cvs2svn 2.1.0 released
Followup-To: gmane.comp.version-control.subversion.cvs2svn.user
Date: Tue, 19 Feb 2008 22:37:32 +0100
Message-ID: <47BB4C1C.3010907@alum.mit.edu>
Reply-To: cvs2svn users <users@cvs2svn.tigris.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: announce@cvs2svn.tigris.org, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 22:38:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRaAW-0006hz-Bh
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 22:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754648AbYBSVhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 16:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754562AbYBSVhy
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 16:37:54 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:36412 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754550AbYBSVhx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 16:37:53 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.135] (kaiserty.in-dsl.de [217.197.85.174])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id m1JLbnXd013325
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 19 Feb 2008 22:37:49 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.8pre) Gecko/20071022 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
X-Enigmail-Version: 0.95.0
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74461>

cvs2svn 2.1.0 has been released.

cvs2svn is a tool for converting a CVS repository into a Subversion or
git repository.  cvs2svn can convert just about any CVS repository we've
ever seen, including gcc, Mozilla, FreeBSD, KDE, GNOME...

Some highlights of release 2.1.0 are:

  * First official release that supports conversions from CVS to git as
well as CVS to Subversion.
  * More flexible symbol transform and symbol strategy rules, including
manual rules read from a symbol hints file.
  * Allow an arbitrary SVN path to be set for each branch/tag directory.
  * Improved conversion speed.
  * Improved quality of conversion and toleration for more kinds of CVS
repository corruption.
  * Fixed a few minor bugs.

For more information see:
http://cvs2svn.tigris.org/source/browse/cvs2svn/tags/2.1.0/CHANGES?rev=4382&view=markup

You can get it here:
http://cvs2svn.tigris.org/files/documents/1462/41596/cvs2svn-2.1.0.tar.gz

The MD5 checksum is df6d42c94f99aeedffa8c438dbb7ac3d

Please send any bug reports and comments to users@cvs2svn.tigris.org.

Michael Haggerty
