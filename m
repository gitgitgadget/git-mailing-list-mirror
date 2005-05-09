From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Git-aware Darcs: a tutorial
Date: Mon, 09 May 2005 10:55:12 -0700
Message-ID: <427FA400.2060408@zytor.com>
References: <7i4qdc8isd.fsf@lanthane.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: darcs-devel@abridgegame.org, darcs-users@abridgegame.org,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 09 20:33:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVCNW-0004Vb-Jr
	for gcvg-git@gmane.org; Mon, 09 May 2005 19:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVEIR4H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 13:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVEIR4H
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 13:56:07 -0400
Received: from terminus.zytor.com ([209.128.68.124]:20150 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261460AbVEIRzy
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 May 2005 13:55:54 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j49HtIKg028051
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 9 May 2005 10:55:18 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
In-Reply-To: <7i4qdc8isd.fsf@lanthane.pps.jussieu.fr>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Juliusz Chroboczek wrote:
> 0. What is Darcs-git
> 
> Darcs-git is a branch of Darcs that can work with Git repositories.
> 
> Darcs-git is deliberately Darcs, not Git.  All commands either work in
> the same way on Git repositories as on Darcs repositories, or they
> fail.  If you're a Darcs user, you'll like darcs-git.  If you're a Git
> user, you'll probably find it infuriating.
> 
> On the other hand, Darcs-git uses stock Git repositories; a Darcs
> command either works as-is on a Git repository, or fails.
> 

How is it, performance-wise?

	-hpa
