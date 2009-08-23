From: Sam Vilain <sam@vilain.net>
Subject: Re: [RFC/PATCH 1/3] gitweb: make suspenders more useful
Date: Mon, 24 Aug 2009 10:48:45 +1200
Message-ID: <4A91C74D.1080908@vilain.net>
References: <4A91BA66.5050108@mailservices.uwaterloo.ca> <4A91BE50.7070103@vilain.net> <4A91C512.7000707@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Mon Aug 24 00:49:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfLrw-0005Md-1u
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 00:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbZHWWsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 18:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbZHWWsu
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 18:48:50 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:48833 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801AbZHWWsu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 18:48:50 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 96B6B21C3BC; Mon, 24 Aug 2009 10:48:50 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id DEC7821C385;
	Mon, 24 Aug 2009 10:48:45 +1200 (NZST)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <4A91C512.7000707@mailservices.uwaterloo.ca>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126894>

Mark Rada wrote:
>>> Subject: [RFC/PATCH 1/3] gitweb: make suspenders more useful
>>>       
>> Suspenders?  Really?
>>     
> Context:
>
> On 21/08/09 5:43 PM, Junio C Hamano wrote:
>   
>> I do not mind keeping these two lines as belt-and-suspender, though.
>>     
> Yup...I couldn't think of an appropriate title and I expect this
> patch to be edited (for another reason) or thrown out anyways.
>   

Please don't do that.  Use of metaphors makes the code harder to follow,
especially for non-native speakers.  In this case you confused me, a
British/NZ native speaker because you only used half of the idiom; so
all I was left with was a word which in the English where I speak refers
to a piece of clothing worn most often by prostitutes and people at the
Rocky Horror Picture Show.

Can I suggest "snapshot error handling" as a more neutral term...
Sam
