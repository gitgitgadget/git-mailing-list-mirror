From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: What is not in git.git
Date: Thu, 05 Feb 2009 08:35:45 +0900
Message-ID: <20090205083545.6117@nanako3.lavabit.com>
References: <20090205054918.6117@nanako3.lavabit.com> <7vy6wllswz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, ecashin@coraid.com, arjen@yaph.org,
	joey@kitenet.net, benny.kra@googlemail.com, pw@padd.com,
	simon@lst.de, jidanni@jidanni.org, dirker@gmail.com,
	hoxu@users.sf.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 00:38:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUrK7-0002Cz-R2
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 00:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163AbZBDXgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 18:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756616AbZBDXgf
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 18:36:35 -0500
Received: from karen.lavabit.com ([72.249.41.33]:60767 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752275AbZBDXge (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 18:36:34 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id BDA54C86B2;
	Wed,  4 Feb 2009 17:36:33 -0600 (CST)
Received: from 2653.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id O3QD0ZPJ87ZE; Wed, 04 Feb 2009 17:36:33 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=g4OMOaz8tdqoQpwvtJHkrwoKCk2kqvYEBPL9GbJYUgF86CYAj8+tJ4Y44iU9zIJK7pPDP/VfvOrRgbfLL/6Ij/ZdDsNtAWoblDNykVC7HceKs2I6EuAgF34QxF+BAKSdcV6eflJYmuYW/r31pd/lIQMSUyXfntRENaL+aNoiGKQ=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vy6wllswz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108465>

Quoting Junio C Hamano <gitster@pobox.com> writes:

> Nanako Shiraishi <nanako3@lavabit.com> writes:
>
>>  5. From: jidanni@jidanni.org
>>     Subject: [PATCH] Documentation/git-show-branch.txt: compact -g
>>     Date: Tue,  6 Jan 2009 11:14:02 +0800
>>     Message-Id: <1231211642-14463-1-git-send-email-jidanni@jidanni.org>
>>
>>     I couldn't figure out what "compact -g" meant but other than that I
>>     think this patch is correct. Perhaps Junio has the author in his mail
>>     ignore list?
>
> I do not have anybody in my killfile.  I think this patch is Ok with a
> minor fix to log as you say.  How about
>
> 	git-show-branch doc: show -g as synonym to --reflog in the list

That is very readable.

> Thanks.  I wish there were more like you.

You're welcome.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
