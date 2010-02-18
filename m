From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Add new option in the right click menu in git gui
Date: Fri, 19 Feb 2010 00:11:57 +0100
Message-ID: <7fce93be1002181511v1c671f82u7f3d7cc6e3512bab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 19 00:12:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiFXQ-0001SA-NN
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 00:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741Ab0BRXL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 18:11:59 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:48468 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab0BRXL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 18:11:59 -0500
Received: by ewy19 with SMTP id 19so7439831ewy.21
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 15:11:58 -0800 (PST)
Received: by 10.213.104.88 with SMTP id n24mr198980ebo.22.1266534717709; Thu, 
	18 Feb 2010 15:11:57 -0800 (PST)
X-Originating-IP: [82.233.66.33]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140393>

Hi,

In case of conflicts it is possible in git gui, through the right
click menu, to use local or remote versions, but, unless I missed
something, it is not possible, after using the merge tool, to add
merged files to the index.

It would be nice if we could add merged files in the index directly in git gui.

Besides, having this third option will avoid the mistake I used to
make when I was a git beginner, knowing, after using the merge tools I
was using the "use local version" options thinking it will add to the
index the local changes I just made to the conflicted file.

Regards.

-- 
Sylvain
