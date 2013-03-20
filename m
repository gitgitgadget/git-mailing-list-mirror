From: Rob Hoelz <rob@hoelz.ro>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Wed, 20 Mar 2013 13:33:12 +0100
Message-ID: <5149AC88.9090206@hoelz.ro>
References: <20130318220224.3b23a381@hoelz.ro> <20130318231043.GD5062@elie.Belkin> <7v38vsma9o.fsf@alter.siamese.dyndns.org> <20130319015541.GH5062@elie.Belkin> <7vwqt3i7p9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	josh@joshtriplett.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 13:33:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIICs-00043X-Ka
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 13:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757974Ab3CTMc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 08:32:58 -0400
Received: from hoelz.ro ([66.228.44.67]:36098 "EHLO mail.hoelz.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756169Ab3CTMc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 08:32:58 -0400
Received: from Robs-MacBook-Pro.local (localhost [127.0.0.1])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.hoelz.ro (Postfix) with ESMTPSA id D7FF6280EE;
	Wed, 20 Mar 2013 08:32:56 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:17.0) Gecko/20130216 Thunderbird/17.0.3
In-Reply-To: <7vwqt3i7p9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218596>

On 3/19/13 7:08 PM, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Junio C Hamano wrote:
>>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>>> Test nits:
>>>> ...
>>>> Hope that helps,
>>>>
>>>> Jonathan Nieder (3):
>>>>   push test: use test_config where appropriate
>>>>   push test: simplify check of push result
>>>>   push test: rely on &&-chaining instead of 'if bad; then echo Oops; fi'
>>> Are these supposed to be follow-up patches?  Preparatory steps that
>>> Rob can reroll on top?  Something else?
>> Preparatory steps.
> OK, thanks.  I'll queue these first then.
>
Should I apply these to my patch to move things along?  What's the next
step for me?

Thanks,
Rob
