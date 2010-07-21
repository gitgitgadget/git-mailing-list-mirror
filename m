From: Zeeshan Qureshi <zeeshan@zqureshi.in>
Subject: Re: Git commit behaving strangely
Date: Wed, 21 Jul 2010 00:01:10 -0400
Message-ID: <AANLkTin9cGW77iqXR63XPmJkft_RXjw5nLkdmUNIjgmA@mail.gmail.com>
References: <4C465B34.2040407@zqureshi.in>
	<20100721030608.GA25992@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 21 06:01:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObQUp-0002La-Mo
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 06:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742Ab0GUEBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 00:01:12 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:65209 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab0GUEBL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jul 2010 00:01:11 -0400
Received: by gxk23 with SMTP id 23so3349214gxk.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 21:01:10 -0700 (PDT)
Received: by 10.90.63.2 with SMTP id l2mr771167aga.185.1279684870262; Tue, 20 
	Jul 2010 21:01:10 -0700 (PDT)
Received: by 10.91.6.4 with HTTP; Tue, 20 Jul 2010 21:01:10 -0700 (PDT)
X-Originating-IP: [65.93.161.138]
In-Reply-To: <20100721030608.GA25992@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151388>

Hello Jonathan,

The problem seems to be with the Blastwave git package (it 1.6.x) on Solaris.

I tried reproducing it on 2 different linux machines (both running git
1.7) and I couldn't reproduce it.

I will do it again when I get to work tomorrow (i don't have remote
access to the workstation) and post the results.

Thanks,
Zeeshan
