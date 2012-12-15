From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH] README: Git is released under the GPLv2, not just "the
 GPL"
Date: Sat, 15 Dec 2012 20:58:08 +0100
Message-ID: <50CCD650.40303@gmail.com>
References: <966a27bab02e7deb41ad2268800bfd4a53279a8f.1355499408.git.stefano.lattarini@gmail.com> <7vhanntchw.fsf@alter.siamese.dyndns.org> <7v38z7tb7q.fsf@alter.siamese.dyndns.org> <50CCCE0A.40305@gmail.com> <7vhannrtot.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 20:58:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjxsU-0000my-Ki
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 20:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549Ab2LOT6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 14:58:13 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48596 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab2LOT6N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 14:58:13 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so2210374bkw.19
        for <git@vger.kernel.org>; Sat, 15 Dec 2012 11:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=tJZ6PF4zNV1KvjzwjTQQiXyy0V4qoceMYiEcaEquz5s=;
        b=Ku6KCVGsAARku90t7sLYReZu6wwqzBK+c9tSudCsIgJ146l6cBsqVvxbP1nD/wdPHk
         Cj0WEeFucDD13PjceGn1+ikriDRzOseqj7sapiBGdfNQDEtydiBpaLZ5BSHtlpv8acre
         NEdp9S0BlXy4y6c8TXxhvuyhTW+c+TuvmKnAfuUQtogQeLeOt1qQpEdpUuWEGW0wqwGO
         Ij2JOGe5f26zvvD9Gu14J8EQAWk33nKB2aGSW3eJWk/aVAsHd+9TXTf7/dKAv/n3v1Pe
         gfxKc5zjjbqI2Ey0QQHdiJP2nfDEAfzsRzUsQAxRPFL4BNlUs7M42PM1B8O09WEuKX+n
         e/1Q==
Received: by 10.204.11.208 with SMTP id u16mr4344960bku.81.1355601491637;
        Sat, 15 Dec 2012 11:58:11 -0800 (PST)
Received: from [192.168.178.21] (host137-94-dynamic.4-87-r.retail.telecomitalia.it. [87.4.94.137])
        by mx.google.com with ESMTPS id r16sm6703561bkv.3.2012.12.15.11.58.09
        (version=SSLv3 cipher=OTHER);
        Sat, 15 Dec 2012 11:58:10 -0800 (PST)
In-Reply-To: <7vhannrtot.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211568>

On 12/15/2012 08:39 PM, Junio C Hamano wrote:
> Stefano Lattarini <stefano.lattarini@gmail.com> writes:
> 
>> On 12/15/2012 07:35 PM, Junio C Hamano wrote:
>>> ...
>>> -Git is an Open Source project covered by the GNU General Public License.
>>> +Git is an Open Source project covered by the GNU General Public
>>> +License version 2 (some parts of it are under different licenses).
>>>
>> Maybe you could be even more explicit ans state "some parts of it are
>> under different licenses, compatible with the GPLv2".  But maybe this
>> is just overkill?
> 
> I personally do not think it is an overkill; because this "clarify
> that we are version 2", followed by "not everything is, but as a
> whole it is still GPLv2" is in the end about covering our ass, it is
> better to be as clear as possible without making it into a novel.
> 
Well, if you put it this way :-)  I agree that it's better be safe
than be sorry.

Thanks,
  Stefano
