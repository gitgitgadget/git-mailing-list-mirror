From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/2] git-config.txt: properly escape quotation marks in
 example
Date: Sun, 19 Aug 2012 11:33:21 +0200
Message-ID: <5030B2E1.5020102@alum.mit.edu>
References: <1345311130-20426-1-git-send-email-mhagger@alum.mit.edu> <1345311130-20426-2-git-send-email-mhagger@alum.mit.edu> <7v7gswrkvm.fsf@alter.siamese.dyndns.org> <7vmx1rrcr4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 19 11:40:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T31zl-0001Vf-1N
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 11:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759Ab2HSJk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 05:40:28 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:50745 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751073Ab2HSJk0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Aug 2012 05:40:26 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Aug 2012 05:40:26 EDT
X-AuditID: 1207440e-b7f036d0000008b5-1f-5030b2e4c72a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 85.F0.02229.4E2B0305; Sun, 19 Aug 2012 05:33:24 -0400 (EDT)
Received: from [192.168.69.140] (p57A24F38.dip.t-dialin.net [87.162.79.56])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7J9XLmn000427
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 19 Aug 2012 05:33:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <7vmx1rrcr4.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqPtkk0GAwZMzshZdV7qZLBp6rzA7
	MHlcvKTs8XmTXABTFLdNUmJJWXBmep6+XQJ3Rt9v2YIHrBUvzm9mamA8ztLFyMkhIWAicbf9
	EhuELSZx4d56IJuLQ0jgMqPEv5Y7jBDOaSaJ7Q+7WEGqeAW0JVY9fM8EYrMIqEqsmf6IHcRm
	E9CVWNTTDBYXFQiRWPNtCiNEvaDEyZlPwLaJCKhJTGw7BGRzcDALiEv0/wMLCwuESkw98Qhq
	8UVGiRmN3WBzOAXMJL5uvs4GUW8t8W13EUiYWUBeYvvbOcwTGAVmIdkwC6FqFpKqBYzMqxjl
	EnNKc3VzEzNzilOTdYuTE/PyUot0jfVyM0v0UlNKNzFCQpRvB2P7eplDjAIcjEo8vFpaBgFC
	rIllxZW5hxglOZiURHmVgAEuxJeUn1KZkVicEV9UmpNafIhRgoNZSYTXPxcox5uSWFmVWpQP
	k5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4E0DGSpYlJqeWpGWmVOCkGbi4AQZziUl
	Upyal5JalFhakhEPitL4YmCcgqR4gPZGgLTzFhck5gJFIVpPMepyfH568i6jEEtefl6qlDhv
	E0iRAEhRRmke3ApYQnrFKA70sTBvNEgVDzCZwU16BbSECWjJo7lgS0oSEVJSDYxTdKfcqz+l
	kV8g+ydhn7Bgwqlvayt37QqZ3aEe7PoqeOaTbdcbdDQE3vvs1zdYX7MlX8m95BXLrgX6hf8K
	2f/86OTilvnQzheRvqvPx1RghjlXFIveBYtvy+6Jp9gUrW16uiE7+IReM7fd0ueO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203715>

On 08/19/2012 01:39 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> The bigger question is whether this example is improved by including
>>> quotation marks, or whether they are just a distraction from the main
>>> point.  I abstain.
>>
>> Thanks for spelling that bigger question out.  Given that the
>> example is showing distinction between "X" vs "X for Y", I would say
>> quotation is a distraction.
>> [...]
>
> I think the answer is "no", there is no way to specify anything
> other than a "path to the command" for gitproxy.  So I think we
> should do this instead:  [...]

ACK.  Thanks.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
