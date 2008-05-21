From: "Craig L. Ching" <cching@mqsoftware.com>
Subject: Git-new-workdir
Date: Wed, 21 May 2008 13:21:22 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F794301FC8B1D@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 21 20:37:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JytBm-0004GA-U4
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 20:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755116AbYEUSgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 14:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755059AbYEUSgh
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 14:36:37 -0400
Received: from emailmn.mqsoftware.com ([66.192.70.108]:9548 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbYEUSgg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 May 2008 14:36:36 -0400
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 May 2008 14:36:36 EDT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Git-new-workdir
Thread-Index: Aci7b3kH+1ISWiLNQ9+Hw5rmQFMEVA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82562>

Hi all,

I'm a bit of a newbie to Git, but I have started using it in earnest for
the past couple of months.  I had asked on IRC about a potential problem
I saw with git and how it fit into our workflow.  We currently use CVS
and have used it for the past ten years.  A lot of us have grown
accustomed to keeping multiple builds around for different things, e.g.
defects we're working on, new features, etc., we do a lot of task
switching and very rarely can we work on something start to finish
without being interrupted with something else.  The normal workflow of
git seems to cut across that need to keep many builds around.
Generally, building our software is not trivial and takes a fair amount
of time, so just "git checkout" out a new branch and rebuilding is not
really an option for us.  I jumped on IRC while back and the contrib
git-new-workdir was sugggested, but with the caveat that I should try
and think outside the box before I adopted git-new-workdir.  So, I come
here, after using Git for a couple of months and not seeing a way around
this, asking if I'm missing something?  Should I be using
git-new-workdir?  Or is there a better way that I have yet to see?  I'm
sure the kernel developers must have this need as well, so it's quite
possible I'm missing something.  I appreciate all feedback!

Cheers,
Craig
