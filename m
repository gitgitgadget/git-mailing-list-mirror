From: Evel <o0oke@qq.com>
Subject: GIT windows version Switch Caps Lock button issue on the input windows
Date: Wed, 3 Feb 2016 01:02:23 +0000 (UTC)
Message-ID: <loom.20160203T020039-314@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 02:10:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQlxU-0006BT-Qn
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 02:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755049AbcBCBKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 20:10:07 -0500
Received: from plane.gmane.org ([80.91.229.3]:58789 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753598AbcBCBKG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 20:10:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aQlxM-0005zq-Su
	for git@vger.kernel.org; Wed, 03 Feb 2016 02:10:05 +0100
Received: from 92.97.38.59.broad.fs.gd.dynamic.163data.com.cn ([92.97.38.59.broad.fs.gd.dynamic.163data.com.cn])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 02:10:04 +0100
Received: from o0oke by 92.97.38.59.broad.fs.gd.dynamic.163data.com.cn with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 02:10:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 59.38.97.92 (Mozilla/5.0 (Linux; Android 4.4.2; H60-L12 Build/HDH60-L12) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/30.0.0.0 Mobile Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285322>

When I try to press the 'Caps Lock' of the keyboard, and then 
try to input the uppercase string,

but after I switched to capital and finished input, I try to 
press the 'Caps Lock' button again, seems the input still keep 
capital letter for input,

Only when I move my cursor to the other input area and press the 
'Caps Lock' button again, then when I try to input in the Git 
console, then the issue will be fixed.

I am using the newest mintty 2.0.3(x86_64-pc-msys) and installed 
the Google Pinyin for input, Windows 7 64bit system.
