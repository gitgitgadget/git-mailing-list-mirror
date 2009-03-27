From: Mike Gaffney <mr.gaffo@gmail.com>
Subject: Git Download/Bootstrap Suggestion
Date: Fri, 27 Mar 2009 12:09:21 -0500
Message-ID: <49CD0841.9000602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 18:12:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnFav-0001Ip-RY
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 18:11:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755626AbZC0RJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 13:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752734AbZC0RJe
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 13:09:34 -0400
Received: from pp0.asolutions.com ([66.236.120.143]:55848 "EHLO
	pp0.asolutions.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343AbZC0RJd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 13:09:33 -0400
Received: from acews3.asolutions.com (acews3.asolutions.com [192.168.2.179])
	by pp0.asolutions.com (8.14.1/8.14.1) with ESMTP id n2RH9UhG001845
	for <git@vger.kernel.org>; Fri, 27 Mar 2009 12:09:31 -0500
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.7400:2.4.4,1.2.40,4.0.166 definitions=2009-03-27_08:2009-03-27,2009-03-27,2009-03-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0811170000 definitions=main-0903270115
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114913>

I may be missing something, but I would like to request that 
http://git-scm.com/download provide a link to a tarball of the actual 
git clone of the current repository with the repo parked on the latest 
stable. What I mean is that for most of my systems I build git off of 
source but I like to be able to just git pull when I want to update 
them. Currently what I have to do is
- download the source tarball (or the rpm)
- make it
- install it
- use that git clone the real repo
- checkout the newest tag
- make configure
- configure
- make
- make install

It'd be a lot cooler if I could just wget a full get repo on the latest 
tag :)

Just a request, Thanks
    -Mike
