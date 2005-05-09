From: Dave Kleikamp <shaggy@austin.ibm.com>
Subject: Re: kernel.org upgraded to cogito-0.10
Date: Mon, 09 May 2005 11:01:21 -0500
Message-ID: <1115654481.10503.8.camel@localhost>
References: <427F70F4.4030409@zytor.com> <427F828C.8070406@mesatop.com>
	 <427F8803.7030004@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Steven Cole <elenstev@mesatop.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kay Sievers <kay.sievers@vrfy.org>,
	Steve French <smfltc@us.ibm.com>
X-From: git-owner@vger.kernel.org Mon May 09 19:35:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVAaF-00013m-GK
	for gcvg-git@gmane.org; Mon, 09 May 2005 17:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVEIQBa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 12:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVEIQBa
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 12:01:30 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:19589 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261441AbVEIQB2
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 May 2005 12:01:28 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j49G1R4I662480
	for <git@vger.kernel.org>; Mon, 9 May 2005 12:01:27 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j49G1QFL367506
	for <git@vger.kernel.org>; Mon, 9 May 2005 10:01:26 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j49G1QiH019065
	for <git@vger.kernel.org>; Mon, 9 May 2005 10:01:26 -0600
Received: from kleikamp.austin.ibm.com (dyn95390155.austin.ibm.com [9.53.90.155])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j49G1Psh019037;
	Mon, 9 May 2005 10:01:26 -0600
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <427F8803.7030004@zytor.com>
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-05-09 at 08:55 -0700, H. Peter Anvin wrote:
> > Unrelated, but the repo at .../sfrench/cifs-2.6.git gives a
> > 403 Forbidden - Invalid project directory from the web interface.
> 
> That's because he has a .git directory inside another .git directory.

I was working with Steve Friday afternoon to set up this repo.  We quit
for the weekend before we realized we didn't initialize the repository
correctly.  We'll fix it.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

