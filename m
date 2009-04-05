From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Sun, 5 Apr 2009 16:55:58 -0400
Message-ID: <76718490904051355p2f92d445j860c56638118a604@mail.gmail.com>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
	 <7vmyausz3h.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530904051228m4e57ec90y810dded41f47e443@mail.gmail.com>
	 <7v7i1yrj3t.fsf@gitster.siamese.dyndns.org>
	 <7vzleuq3ci.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530904051341s7e8718c2uced945a16c26670e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 22:59:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqZRI-00017e-5Q
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 22:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670AbZDEU4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 16:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753618AbZDEU4D
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 16:56:03 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:53682 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbZDEU4B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 16:56:01 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1852229ywb.1
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 13:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=u1NGQphXn742qt3bN0hG+32PGfqDCUvy55xdkXPDB3I=;
        b=b4C/neZxti6fJTLCdfeRGFSJz3Kv3KysTnonJEWmmt64dak0DZhOIID1pD48inji4I
         BjFwJn+Ubvw1Ddb16QslZARxKEV/19IKMDaYO0LKmMobUqlbHhSBFuWOHHK/7LqH/sO8
         +jdLcKf9u/h6mTA+cyRgWqGDKxuhCQIeAlaNU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LQKflBBkNAt6QBswDy0BXNo3SedUPrJrsczE4IMVo1oK1kG2qNZvLcIakGKUlooztv
         lGcPX0Fq7SQDU7Q2C4ULh4x73rSnU7BcJKQjXeKUjLJL7j8j9zYmSNIEYU2hnIb/9JbR
         S3khIZk0SNQB4xmzJvvm5yboOUBHMf5PKKbKk=
Received: by 10.151.42.12 with SMTP id u12mr6946491ybj.236.1238964958957; Sun, 
	05 Apr 2009 13:55:58 -0700 (PDT)
In-Reply-To: <94a0d4530904051341s7e8718c2uced945a16c26670e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115707>

On Sun, Apr 5, 2009 at 4:41 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> == stage ==
>
> The word "stage" is used widely in the English language, and it
> immediately evokes a theatrical stage. Generally, it means a different
> (upper) level.
>
> In git it is barely used, mostly on the "documentation industry"
> probably because it's easier to understand for most people (even
> non-native-English speakers).

Would an index by any other name smell as sweet?

http://www.merriam-webster.com/dictionary/staging%20area

:-)

j.
