From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: [ANNOUNCE] qgit-2.1 and qgit-1.5.8
Date: Mon, 31 Dec 2007 19:47:42 +0200
Message-ID: <47792B3E.60509@panasas.com>
References: <e5bfff550712302335ie96e143g55c93e984fba6aaa@mail.gmail.com>	 <4778CB78.2010906@yahoo.it> <e5bfff550712310358g347d883fm9866f328f24e3ad0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Filippo Zangheri <filippo.zangheri@yahoo.it>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 31 18:48:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9OkH-0001Xi-Kl
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 18:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbXLaRrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 12:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbXLaRrs
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 12:47:48 -0500
Received: from gw-colo-pa.panasas.com ([66.238.117.130]:1043 "EHLO
	cassoulet.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751225AbXLaRrr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 12:47:47 -0500
Received: from riverside.int.panasas.com (localhost.localdomain [127.0.0.1])
	by cassoulet.panasas.com (8.13.1/8.13.1) with ESMTP id lBVHliBl023533;
	Mon, 31 Dec 2007 12:47:45 -0500
Received: from 172.17.1.41 ([172.17.1.41] helo=riverside.int.panasas.com)
	by ASSP-nospam; 31 Dec 2007 12:47:44 -0500
Received: from bh-buildlin2.bhalevy.com ([172.17.28.147]) by riverside.int.panasas.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 31 Dec 2007 12:47:44 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <e5bfff550712310358g347d883fm9866f328f24e3ad0@mail.gmail.com>
X-OriginalArrivalTime: 31 Dec 2007 17:47:44.0817 (UTC) FILETIME=[3FA84A10:01C84BD5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69410>

On Mon, Dec 31 2007 at 13:58 +0200, "Marco Costalba" <mcostalba@gmail.com> wrote:
> On Dec 31, 2007 11:59 AM, Filippo Zangheri <filippo.zangheri@yahoo.it> wrote:
>> Hi,
>>
>> I git-cloned qgit-2.1 from your repository, then ran `qmake qgit.pro`, but `make` gave me errors.
> 
> Yes, you need qmake of Qt4 not the Qt3 one.
> 
<snip>

A Theoretical question.
Is it possible to compile Qt4 app all statically linked and run it on a Qt3 based KDE
machine. Some thing like the windows installation, where every thing is self-contained?

Thanks
Boaz
