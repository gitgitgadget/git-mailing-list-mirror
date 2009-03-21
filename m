From: Mercedes6s <bsamman@imagitekltd.com>
Subject: How to go to git from svn without checkout
Date: Sat, 21 Mar 2009 10:02:57 -0700 (PDT)
Message-ID: <22638146.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 18:04:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll4cq-0002qn-FK
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 18:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786AbZCURDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 13:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754274AbZCURDA
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 13:03:00 -0400
Received: from kuber.nabble.com ([216.139.236.158]:42643 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878AbZCURC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 13:02:59 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1Ll4b3-0002V8-8N
	for git@vger.kernel.org; Sat, 21 Mar 2009 10:02:57 -0700
X-Nabble-From: bsamman@imagitekltd.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114044>


Hello.  I've been falling more and more in love with git and I want to move
our biggest project biggest it is my biggest pain over to git to make our
lives easier.  The problem is our project is about 50 gigs (A lot of media
files involved).  Also, we got developers all over the world that are
running on slow connections.  Some took a week to get the project up and
running in the first place.  Luckily, they are only isolated instances. 
What I'm wondering is can I have all of them turn their projects into git
repositories locally and have all of them sync with a master repository once
they are done.  The actual project is only about 500 megs and the changes
are probably only a few K since they keep their projects up to date, so
that's more acceptable, but I don't want them to bring down all those media
files again and I doubt they will be willing to do it.  Is this possible,
and how would I do it?  

thanks
-- 
View this message in context: http://www.nabble.com/How-to-go-to-git-from-svn-without-checkout-tp22638146p22638146.html
Sent from the git mailing list archive at Nabble.com.
