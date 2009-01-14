From: Nicholas LaRoche <nlaroche@vt.edu>
Subject: git Thunderbird Synching
Date: Wed, 14 Jan 2009 02:52:26 -0500
Message-ID: <496D99BA.6000208@vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 08:53:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN0ZT-0004oF-Qk
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 08:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756061AbZANHw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 02:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754537AbZANHw1
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 02:52:27 -0500
Received: from lennier.cc.vt.edu ([198.82.162.213]:39320 "EHLO
	lennier.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbZANHw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 02:52:26 -0500
Received: from steiner.cc.vt.edu (IDENT:mirapoint@steiner.cc.vt.edu [198.82.163.51])
	by lennier.cc.vt.edu (8.13.8/8.13.8) with ESMTP id n0E7qPSk012909
	for <git@vger.kernel.org>; Wed, 14 Jan 2009 02:52:25 -0500
Received: from auth.smtp.vt.edu (EHLO authsmtp2.cc.vt.edu) ([198.82.161.56])
	by steiner.cc.vt.edu (MOS 3.10.2-GA FastPath queued)
	with ESMTP id KPH01382;
	Wed, 14 Jan 2009 02:52:24 -0500 (EST)
Received: from [192.168.93.154] (pool-72-86-63-93.clppva.east.verizon.net [72.86.63.93])
	(authenticated bits=0)
	by authsmtp2.cc.vt.edu (8.13.1/8.13.1) with ESMTP id n0E7qOqg000366
	for <git@vger.kernel.org>; Wed, 14 Jan 2009 02:52:24 -0500
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
X-Mirapoint-Received-SPF: 198.82.161.56 authsmtp2.cc.vt.edu nlaroche@vt.edu 2 pass
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105597>

Has anyone tried to synch a Thunderbird profile between two computers 
with git?

I want to do something like this with my main profile, but I'm concerned 
that if I send/receive email on either machine independently that there 
will be corruption in some of the files when I push back to my main box.

Regards,
Nick
