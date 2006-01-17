From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Cogito wishlist: ability to set merge strategy
Date: Mon, 16 Jan 2006 19:29:49 -0800
Message-ID: <43CC64AD.30606@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 17 04:30:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyhXx-0002oZ-4q
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 04:30:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWAQD35 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 22:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWAQD35
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 22:29:57 -0500
Received: from terminus.zytor.com ([192.83.249.54]:60558 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751331AbWAQD34
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 22:29:56 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k0H3TnTB020101
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 16 Jan 2006 19:29:51 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>, Git Mailing List <git@vger.kernel.org>
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14773>

It would be nice if Cogito would let one override the default merge 
strategy, i.e. to use the recursive merge strategy.  I've had some 
moderate luck with using recursive merge for the klibc trees recently.

	-hpa
