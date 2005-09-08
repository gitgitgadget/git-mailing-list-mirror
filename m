From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: git/cogito suggestion: tags with descriptions
Date: Wed, 07 Sep 2005 22:10:59 -0400
Message-ID: <431F9DB3.5090204@gmail.com>
References: <20050905184551.GA14720@tumblerings.org> <7vu0gw1htd.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Zack Brown <zbrown@tumblerings.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 04:11:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDBsZ-00072O-La
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 04:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbVIHCLE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Sep 2005 22:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbVIHCLE
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Sep 2005 22:11:04 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:55422 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932561AbVIHCLC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2005 22:11:02 -0400
Received: by wproxy.gmail.com with SMTP id i2so1087138wra
        for <git@vger.kernel.org>; Wed, 07 Sep 2005 19:11:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=SDSUQXBcl94GLTCmx7qO+MqgDJs0mVk49y02ue61HIl7/OeRubINqh/GuSveselzYkF9pBu2WIyL6/6Mj2VPPlluAv0hpbt68i0kO7xnoKGKTsCtEK+PeP5fvFGl9Ij7ahpe+Jw5M7KKshZkknXTUdFGYn5tavTlKNZ4nZRHd1g=
Received: by 10.54.29.44 with SMTP id c44mr2641239wrc;
        Wed, 07 Sep 2005 19:11:01 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id 6sm518569wrl.2005.09.07.19.11.01;
        Wed, 07 Sep 2005 19:11:01 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0gw1htd.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8191>

Junio C Hamano wrote:
> Zack Brown <zbrown@tumblerings.org> writes:
> 
>>It would be great if tags also allowed a brief description to go along with
>>them, that would show up in cg-tag-ls. Then I could seek to a tag that's just
>>an easy-to-type version number, and still have an idea of what's significant
>>about that version because of the descriptive text.
> 
> Do people crave for 'git tag' showing list of tags with their
> brief descriptions just like 'git branch' does?

Sort of like what gitweb does now?
