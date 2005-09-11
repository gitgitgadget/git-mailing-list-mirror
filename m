From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [RFC] GIT Repository Annotation Convention
Date: Sun, 11 Sep 2005 14:08:24 -0400
Message-ID: <43247298.2010500@gmail.com>
References: <87ll2aib73.fsf@gmail.com> <431DA8CD.9060009@gmail.com> <432060B8.6080408@gmail.com> <7vr7bzv3r2.fsf@assigned-by-dhcp.cox.net> <432089D5.7000102@gmail.com> <pan.2005.09.11.16.37.20.483911@smurf.noris.de>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Sep 11 20:10:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEWFm-0005lJ-M7
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 20:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbVIKSIc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 14:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbVIKSIc
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 14:08:32 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:7118 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965004AbVIKSIb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 14:08:31 -0400
Received: by wproxy.gmail.com with SMTP id i20so1639133wra
        for <git@vger.kernel.org>; Sun, 11 Sep 2005 11:08:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=hEmunKlpnZ9jAOyF8VKUu2u0yo/X2wo5iBqZ4x1JiY2vIZRBroKx2goxa0M+wwYibNksiiK/3nhxPCYVH92SWEsK9AkKcFhTrGSWYmnIEx1f//X2/RY23xhQMauoR4UnWMQW1s5ObKu4VVh8QH8IFBebw/k7gYcDWUSpyw/uqn8=
Received: by 10.54.23.14 with SMTP id 14mr749240wrw;
        Sun, 11 Sep 2005 11:08:26 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id d75sm832501wra.2005.09.11.11.08.25;
        Sun, 11 Sep 2005 11:08:25 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <pan.2005.09.11.16.37.20.483911@smurf.noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8312>

Matthias Urlichs wrote:
> Hi, A Large Angry SCM wrote:
> 
>>Think about a directory containing directories "foo" and "foo.txt":
>>
> Can you tell us why you're using extensions in the first place?
> 
> I propose using no extensions whatsoever: simply mirror the refs/ tree.
> 

The extensions allow the annotation of directories as well as files. 
That's something that can't be done if extensions are not used.
