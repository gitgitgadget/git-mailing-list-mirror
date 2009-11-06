From: Abdelrazak Younes <younes@lyx.org>
Subject: Re: [QGIT PATCH/RFC]
Date: Fri, 06 Nov 2009 09:16:31 +0100
Organization: LyX
Message-ID: <4AF3DB5F.3030704@lyx.org>
References: <4AF19630.2070402@lyx.org> <e5bfff550911050141t751d45a0r4e340fa0d10af366@mail.gmail.com> 	<4AF2A538.7040303@lyx.org> <4AF2A69F.1090802@lyx.org> <4AF2AAFD.9000309@lyx.org> <e5bfff550911051225s13c6e39dh355dc3ab1c0623f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 09:16:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6Jzs-0003jm-Uj
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 09:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942AbZKFIQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 03:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753651AbZKFIQ3
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 03:16:29 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:44510 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbZKFIQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 03:16:29 -0500
Received: by ey-out-2122.google.com with SMTP id 25so205291eya.19
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 00:16:33 -0800 (PST)
Received: by 10.213.23.84 with SMTP id q20mr446359ebb.55.1257495393260;
        Fri, 06 Nov 2009 00:16:33 -0800 (PST)
Received: from ?192.168.4.216? ([62.161.104.182])
        by mx.google.com with ESMTPS id 5sm5844207eyf.7.2009.11.06.00.16.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 00:16:32 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <e5bfff550911051225s13c6e39dh355dc3ab1c0623f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132282>

Marco Costalba wrote:
> On Thu, Nov 5, 2009 at 11:37, Abdelrazak Younes <younes@lyx.org> wrote:
>   
>> I recompiled qgit with the Qt version and I didn't notice any performance
>> problem with a big repo (Qt).
>>
>>     
>
> In git we don't need to compute hashes of sha strings because they are
> already hashed !
>   

Now you tell it, it's obvious indeed :-)

Thanks,
Abdel.
