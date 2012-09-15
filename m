From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: What's cooking in git.git (Sep 2012, #05; Fri, 14)
Date: Sat, 15 Sep 2012 12:08:27 +0200
Message-ID: <k31k35$pc$1@ger.gmane.org>
References: <7vboh82t7p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 12:09:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCpJ4-0002dd-1A
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 12:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370Ab2IOKIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 06:08:50 -0400
Received: from plane.gmane.org ([80.91.229.3]:50864 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234Ab2IOKIt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 06:08:49 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TCpIw-0002a6-MQ
	for git@vger.kernel.org; Sat, 15 Sep 2012 12:08:50 +0200
Received: from dsdf-4db519b7.pool.mediaways.net ([77.181.25.183])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 15 Sep 2012 12:08:50 +0200
Received: from jojo by dsdf-4db519b7.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 15 Sep 2012 12:08:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db519b7.pool.mediaways.net
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205549>

Junio C Hamano wrote:
> I think we can start thinking about feature freeze once the topics
> in 'next' that are scheduled to graduate to 'master' already are
> fully cooked.  For any late-coming topic, there always is the next
> cycle ;-)

I've not hear anything about my poll patches and I'd really like them to 
into 1.8.x.
If and when they did, there's another small patch to fully support HP 
NonStop (some adjustment to git-compat-util.h with #ifdef __TANDEM and a 
NonStop section in Makefile, so nothing that should have any bad impact on 
others), which I too would like to get in 1.8.x

Bye, Jojo 
