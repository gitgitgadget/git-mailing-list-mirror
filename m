From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Suggestion: "man git clone"
Date: Wed, 20 Aug 2008 17:11:08 -0700
Message-ID: <48ACB29C.7000606@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: flucifredi@acm.org, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 21 02:12:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVxmu-0006eQ-3B
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 02:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbYHUALO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 20:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752614AbYHUALO
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 20:11:14 -0400
Received: from terminus.zytor.com ([198.137.202.10]:40123 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbYHUALN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 20:11:13 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m7L0BAKc032065
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 20 Aug 2008 17:11:10 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m7L0BAqO020714;
	Wed, 20 Aug 2008 17:11:10 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m7L0B8Go007187;
	Wed, 20 Aug 2008 17:11:09 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
X-Virus-Scanned: ClamAV 0.93.3/8060/Wed Aug 20 13:17:24 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93075>

Given the recent change of "git-foo" to "git foo", it would be really 
nice if one could type, for example:

	man git clone

and actually get the man page for the git clone command.  There are 
quite a few other pieces of software which also could benefit from that 
kind of indirection.

Right now the above command shows the man page git(1) followed by 
clone(2), which I believe has be classified as utterly useless behaviour...

	-hpa
