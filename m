From: Yves Perron <yves.perron@modusfx.com>
Subject: Re: Don't share anything but those files
Date: Fri, 13 Jul 2012 13:40:56 -0400
Message-ID: <50005DA8.5020803@modusfx.com>
References: <500037EB.5030408@modusfx.com> <20120713152127.GC17521@phobos.chilli.itwm.local> <50004048.9060203@modusfx.com> <20120713161432.GA8770@phobos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Edward Toroshchin <edward.hades@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 19:41:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpjsK-0001kj-P4
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 19:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451Ab2GMRlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 13:41:52 -0400
Received: from modusfx-142-218.cust.b2b2c.ca ([66.158.142.218]:27816 "EHLO
	modusfx.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751800Ab2GMRlv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 13:41:51 -0400
Received: from [10.1.100.132] [10.1.100.132] by modusfx.com with ESMTP
  (SMTPD-11.5) id fdda00005d76ad17; Fri, 13 Jul 2012 13:40:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120420 Thunderbird/12.0
In-Reply-To: <20120713161432.GA8770@phobos>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201412>

Ok, let me rephrase, is there a way to edit a file where we can put 
every files/folders we need to add without the need of entering a 
command for each entry?


On 7/13/2012 12:14 PM, Edward Toroshchin wrote:
> On Fri, Jul 13, 2012 at 11:35:36AM -0400, Yves Perron wrote:
>> Oh I see, thank you for your response,
>>
>> Can I put all the folders/files I want to add in a config file so I
>> don't have to do this every time?
>>
>> Thx
>>
> You won't have to do this every time. Once you add a file and commit it,
> git will track it in the future.
>


--
