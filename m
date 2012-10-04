From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: What's cooking in git.git (Oct 2012, #01; Tue, 2)
Date: Thu, 04 Oct 2012 17:17:56 +0200
Message-ID: <506DA8A4.5080105@alum.mit.edu>
References: <7vmx045umh.fsf@alter.siamese.dyndns.org> <CACsJy8BGuoW6K_9vEgGrb2XC2bNtR=0jNRU3JQhsv7_diGQpbA@mail.gmail.com> <7vbogj5sji.fsf@alter.siamese.dyndns.org> <506D5837.6020708@alum.mit.edu> <CACsJy8DUmjwrkDTePr_8zAU_gcm1kh11J4NVWANMXKsqA6Pb1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:23:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtaC-0001w8-OD
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965624Ab2JDPSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 11:18:00 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:53688 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965609Ab2JDPR7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Oct 2012 11:17:59 -0400
X-AuditID: 12074413-b7f786d0000008bb-16-506da8a6136c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id EC.19.02235.6A8AD605; Thu,  4 Oct 2012 11:17:58 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q94FHuFD017005
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 4 Oct 2012 11:17:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <CACsJy8DUmjwrkDTePr_8zAU_gcm1kh11J4NVWANMXKsqA6Pb1A@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsUixO6iqLtsRW6AwZsOIYuuK91MFg29V5gt
	uqe8ZXRg9tg56y67x8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGf0fp3NWHCRvWLWhmmsDYzt
	bF2MnBwSAiYS83pvMkLYYhIX7q0HinNxCAlcZpR42HGCGcI5xiTR2naavYuRg4NXQFuiZyIv
	SAOLgKrEv2uPwZrZBHQlFvU0M4HYogIhEjMuT2YGsXkFBCVOznzCAmKLCOhInLxzBayeWcBa
	YsXrw2D1wgJ2El9OvGKB2NXJJHF99mRWkASnQKDEzvO3mUD2MguoS6yfJwTRKy+x/e0c5gmM
	ArOQrJiFUDULSdUCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbrmermZJXqpKaWbGCGBK7yD
	cddJuUOMAhyMSjy82i05AUKsiWXFlbmHGCU5mJREeUOW5QYI8SXlp1RmJBZnxBeV5qQWH2KU
	4GBWEuH1zgXK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeJmAESok
	WJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4rT+GJgpIKkeID2vlsOsre4IDEXKArR
	eorRmOPEv7kPGTk+Ns57yCjEkpeflyolzvsGpFQApDSjNA9uESxlvWIUB/pbmFcE5B4eYLqD
	m/cKaBUT0KriSLBVJYkIKakGxvkZondbeqxszlQnf+c25Jv3K6D0/bTaef+EZh350HD9acxB
	1iTJi97GuTNcbVv3CZZOrKpskru8O7BgxX+xo/oKegyuD8sz45rTF8XxmDQsWXW3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206995>

On 10/04/2012 01:46 PM, Nguyen Thai Ngoc Duy wrote:
> On Thu, Oct 4, 2012 at 4:34 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> As for the implementation, it is quite easy to textually convert a glob
>> pattern, including "**" parts, into a regexp.
> 
> Or we could introduce regexp syntax as an alternative and let users
> choose (and pay associated price).

It seems like overkill to me.  For filenames, globs are usually adequate.

>> _filename_char_pattern = r'[^/]'
>> _glob_patterns = [
>>     ('?', _filename_char_pattern),
>>     ('/**', r'(/.+)?'),
>>     ('**/', r'(.+/)?'),
>>     ('*', _filename_char_pattern + r'*'),
>>     ]
> 
> I don't fully understand the rest (never been a big fan of python) but
> what about bracket expressions like [!abc] and [:alnum:]?

You're right; I forgot that the code that I posted doesn't support brackets.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
