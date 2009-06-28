From: Lynn Lin <lynnos@tong-ji.org>
Subject: git push failed over http
Date: Sun, 28 Jun 2009 15:20:18 +0800
Message-ID: <82ec251f0906280020p71026a81w57018e9af4d39396@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 09:20:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKoge-0006dt-Mc
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 09:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbZF1HUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2009 03:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbZF1HUP
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 03:20:15 -0400
Received: from mail-px0-f190.google.com ([209.85.216.190]:33973 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773AbZF1HUP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 03:20:15 -0400
Received: by pxi28 with SMTP id 28so2702466pxi.33
        for <git@vger.kernel.org>; Sun, 28 Jun 2009 00:20:18 -0700 (PDT)
Received: by 10.114.124.1 with SMTP id w1mr9290361wac.13.1246173618218; Sun, 
	28 Jun 2009 00:20:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122395>

Hi,all
       I setup a git public repo (http) over apache2,however I can't
push to remote public repository

$ git push
error: Cannot access URL http://192.168.1.109/demo.git/, return code 22
error: failed to push some refs to 'http://192.168.1.109/demo.git'

Could anyone give some ideas on this problem?


Thanks very much
