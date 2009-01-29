From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: diff settings
Date: Thu, 29 Jan 2009 10:46:12 -0800 (PST)
Message-ID: <alpine.GSO.2.00.0901291044280.23065@kiwi.cs.ucla.edu>
References: <alpine.GSO.2.00.0901240936080.23073@kiwi.cs.ucla.edu> <87ocxwv6qg.fsf@iki.fi> <alpine.GSO.2.00.0901241159050.23073@kiwi.cs.ucla.edu> <497CD352.2060402@tedpavlic.com> <alpine.GSO.2.00.0901251307030.12651@kiwi.cs.ucla.edu> <497D1AB7.7000208@tedpavlic.com>
 <4981D8AD.6000000@tedpavlic.com> <alpine.DEB.1.00.0901291731220.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ted Pavlic <ted@tedpavlic.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 29 19:47:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSbva-0004pc-03
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 19:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754251AbZA2SqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 13:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753844AbZA2SqX
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 13:46:23 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:54038 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756946AbZA2SqW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 13:46:22 -0500
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n0TIkCZV025752;
	Thu, 29 Jan 2009 10:46:12 -0800 (PST)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n0TIkCsf025749;
	Thu, 29 Jan 2009 10:46:12 -0800 (PST)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <alpine.DEB.1.00.0901291731220.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107712>

On Thu, 29 Jan 2009, Johannes Schindelin wrote:

> we already have a distinction between what is called from scripts vs from 
> humans: plumbing vs porcelain.  So you can set the defaults for porcelain as 
> much as you want, but please leave plumbing alone.

May we consider "git diff" Porcelain and "git diff-{files,index,tree}" plumbing?
