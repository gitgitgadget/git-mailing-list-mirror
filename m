From: baluchen <murugan.bala@gmail.com>
Subject: clone URL missing in gitweb
Date: Tue, 17 Jul 2012 23:07:18 -0700 (PDT)
Message-ID: <1342591638170-7563176.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 08:07:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrNPw-0001ln-PZ
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 08:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404Ab2GRGHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 02:07:20 -0400
Received: from sam.nabble.com ([216.139.236.26]:34067 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014Ab2GRGHS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 02:07:18 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <murugan.bala@gmail.com>)
	id 1SrNPq-0004Df-61
	for git@vger.kernel.org; Tue, 17 Jul 2012 23:07:18 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201650>

Hi,

I setup gitweb and it is working. When you click any project in gitweb
following information will be displayed

cloning git clone http://vvvv.domain.com/git/Android/Abalone.git 
description email client - web hybrid 
owner ciebv245a daemon 
last change Thu, 10 May 2012 15:44:36 +0000 


But in my setup i coould not find "cloaning" option

How do i get http url as you see blow

http://git.kernel.org/?p=bluetooth/bluez-gnome.git;a=summary

description Bluetooth applications for GNOME 
owner Marcel Holtmann 
URL git://git.kernel.org/pub/scm/bluetooth/bluez-gnome.git 
 http://git.kernel.org/pub/scm/bluetooth/bluez-gnome.git 
 https://git.kernel.org/pub/scm/bluetooth/bluez-gnome.git 


--
View this message in context: http://git.661346.n2.nabble.com/clone-URL-missing-in-gitweb-tp7563176.html
Sent from the git mailing list archive at Nabble.com.
