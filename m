From: Ian Molton <spyro@f2s.com>
Subject: merging question
Date: Mon, 30 Jan 2006 16:23:15 +0000
Organization: The Dragon Roost
Message-ID: <43DE3D73.60904@f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jan 30 17:19:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3bkf-0008Lf-Mi
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 17:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWA3QT2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 11:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbWA3QT2
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 11:19:28 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:10369 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S932311AbWA3QT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2006 11:19:27 -0500
Received: from [192.168.1.2] (i-195-137-81-187.freedom2surf.net [195.137.81.187])
	by outmail.freedom2surf.net (8.12.10/8.12.10) with ESMTP id k0UGJQVT019927
	for <git@vger.kernel.org>; Mon, 30 Jan 2006 16:19:26 GMT
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051219)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15281>

Is it possible to merge all the changes up to a specific tagged version 
of another branch ?

I'd like to pull all the changes up to 2.6.15 into a branch created from 
2.6.12, which has been subsequently modified. I dont yet want to pull 
later changes in.

on a side note, how does one pull in an individual changeset, rather 
than the head of an entire branch ?
