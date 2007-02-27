From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: How do get a specific version of a particular file?
Date: Tue, 27 Feb 2007 15:25:25 -0800
Message-ID: <86vehnnpy2.fsf@blue.stonehenge.com>
References: <E1HM1XL-00071C-N5@candygram.thunk.org>
	<Pine.LNX.4.63.0702271356040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070227154241.GA8228@thunk.org>
	<Pine.LNX.4.63.0702272053080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070227223929.GA9027@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 28 00:27:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMBj2-0007GG-G4
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 00:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbXB0XZ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 18:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752568AbXB0XZ2
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 18:25:28 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:27779 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbXB0XZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 18:25:26 -0500
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id DACE21DE52A; Tue, 27 Feb 2007 15:25:25 -0800 (PST)
x-mayan-date: Long count = 12.19.14.1.16; tzolkin = 12 Cib; haab = 9 Kayab
In-Reply-To: <20070227223929.GA9027@thunk.org> (Theodore Tso's message of "Tue, 27 Feb 2007 17:39:29 -0500")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40844>

>>>>> "Theodore" == Theodore Tso <tytso@mit.edu> writes:

Theodore> And I'm still not sure why

Theodore> 	git show v1.5.0..v1.5.0.1 

Theodore> doesn't throw an error, and why it prints what it does...

Wait, that doesn't throw an error?

(tries it)

OK, how is that different from git-diff ?

/me scratches head

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
