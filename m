From: Abdelrazak Younes <younes@lyx.org>
Subject: [QGit bug] git user settings not retrieved when launched for Windows
 explorer
Date: Tue, 07 Oct 2008 09:33:28 +0200
Message-ID: <48EB10C8.4070009@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 09:35:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn75j-0000L3-JE
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 09:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbYJGHdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 03:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbYJGHdh
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 03:33:37 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:49618 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980AbYJGHdg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 03:33:36 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 103491AB2C5;
	Tue,  7 Oct 2008 09:33:35 +0200 (CEST)
Received: from [192.168.0.10] (gre92-10-88-181-30-42.fbx.proxad.net [88.181.30.42])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E41141AB33B;
	Tue,  7 Oct 2008 09:33:34 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.1b1pre) Gecko/20080918110343 Shredder/3.0b1pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97680>

Dear Marco,

When I double click on qgit.exe, the user name and email are not shown 
in the user settings (for any of the 3 combo values). But if I run qgit 
from the commandline at the mysysgit bash prompt, the boxes are properly 
filled. I would like to debug it but, as I reported last week, the MSVC 
project doesn't work for me.

By the way, these two edit boxes are not editable on Windows, is that on 
purpose? If yes, maybe we could let the user change them is 'Local 
config' is selected and call the appropriate git function?

Thanks,
Abdel.
