From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Suggestion: "man git clone"
Date: Fri, 22 Aug 2008 07:37:52 -0400
Message-ID: <48AEA510.6040004@gmail.com>
References: <48ACB29C.7000606@zytor.com> <48ACB5F4.3000905@sneakemail.com> <48AD99DF.5090802@zytor.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?IlBldGVyIFZhbGRlbWFyIE3DuHJjaCAoTGlzdHMpIg==?= 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 13:39:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWUyz-0002lm-P8
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 13:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbYHVLiF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Aug 2008 07:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbYHVLiF
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 07:38:05 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:60544 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481AbYHVLiD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 07:38:03 -0400
Received: by yx-out-2324.google.com with SMTP id 8so261977yxm.1
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 04:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ngmAQBkilqWtNtllds7CQF3JH/ddek5MmhrF/o7TQlk=;
        b=vQonh4d+sM4lcKJFeDPJviaxDg3wcjrYCoWP4iqN1QavG8L7oQHHog/iPt3OH5748P
         IAVR4kadq4IuFEJlCjdmkceSkXxyGtutP9n1W6YAMRobZuXyfpKed+ciKaTtGwmgX8AD
         +bZczFiaGkH/wEsBQZBERuRnMYPsPDi8vp3SY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=wytSiXaI59Ck09ucma9wMLaeW301nWLu4YWIaXmLb0W5eQqFUCpeYEL3lwAOu4WuGL
         4ITJE6/I3TxJCix+Zpw2PzmtKh3D/yZQNSrrxhERvhj5IjT6hMFKB7hxAM72CWWiii/k
         hAWcYbiiqo0jOORe0+5mPzn4l43ZbBPECCsxw=
Received: by 10.150.230.15 with SMTP id c15mr1687056ybh.80.1219405082253;
        Fri, 22 Aug 2008 04:38:02 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id 9sm1521278yws.5.2008.08.22.04.37.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Aug 2008 04:38:00 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <48AD99DF.5090802@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93283>

H. Peter Anvin wrote:
> Peter Valdemar M=C3=B8rch (Lists) wrote:
>>
>> Sorry man that behaviour is the way "man" works. See "man man".
>>
>>   $ git clone --help
>> or
>>   $ git help clone
>>
>> work right?
>>
>> Peter
>>
>> P.S: man, there are puns in that...
>=20
> I know that that is the way "man" currently works.
>=20
> I doubt you find *anyone* who relies on the current behaviour, so I a=
m=20
> suggesting changing man.  That's why the man author was on the recipi=
ent=20
> list, but you removed it.

Actually, the current "man" behavior is very convenient when  you want=20
to lookup multiple things. And *I* do use that feature.
