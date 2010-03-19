From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 10:13:14 -0400
Message-ID: <46a038f91003190713m5d99a38fo898d9d2391103f3@mail.gmail.com>
References: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org> 
	<b4087cc51003181457s76560b02y84aafbe77f45af87@mail.gmail.com> 
	<4BA36F5F.9080706@gnu.org> <b4087cc51003190543mafc403q6260a3774653e2d5@mail.gmail.com> 
	<4BA373C0.2070506@gnu.org> <b4087cc51003190603v259b833embb40b7360a07cf1f@mail.gmail.com> 
	<4BA3776B.5040706@gnu.org> <b4087cc51003190613y2fe32c26jd27cb009e64f197c@mail.gmail.com> 
	<873DD7AF-6D5C-4F5F-BDC1-1F26480D412F@wincent.com> <b4087cc51003190659h3d619fdbgc57ce343ee0527a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wincent Colaiuta <win@wincent.com>,
	Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 15:13:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NscxJ-0002Aa-82
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 15:13:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688Ab0CSONg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 10:13:36 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53816 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362Ab0CSONf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 10:13:35 -0400
Received: by gyg8 with SMTP id 8so1582069gyg.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 07:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Ue5am+8YJZWTDqXilcpY1/XL0CSgeUVKSD0l3k5U6pY=;
        b=ruVzUseHO8M6cxMsDKiJ/ih1XwGoHgetWniyrIpPXK/LRMIdl1ms2RFMmz5NDzm7W5
         JBlMXwjBNCTj43Oa56hX8M8e8suinQSZk9FM5mmbJctYzgx8HOYJr4n+qX8iXUL+BjB8
         5C6FdiR0Cn0XCvpQtUQ1gRn38L2bjtKwJS0K8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=uUUdGUPq+45FwjbMNBQPtytElr2AAq/jiQmmkykRg3i0yqK3CMRc3XQYLJJiPGkZQX
         k+/5yCnH3ju+P9RuogYwp/bU73bK1EOgvRU0TDlDpLhcBP+1ml5YAshpRQqXswrrd+Ut
         Z8v+bgAW++lQvpVNAqPUtiRLFMBnW0aAmkuR0=
Received: by 10.101.195.14 with SMTP id x14mr7324003anp.200.1269008014087; 
	Fri, 19 Mar 2010 07:13:34 -0700 (PDT)
In-Reply-To: <b4087cc51003190659h3d619fdbgc57ce343ee0527a3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142600>

On Fri, Mar 19, 2010 at 9:59 AM, Michael Witten <mfwitten@gmail.com> wrote:
> I've shown immense patience repeatedly explaining

No, you haven't. _You_ are misunderstanding.

We have what you want: email + name, and a mapping mechanism (mailmap)
to cope with variations. It is good enough.

> Indeed, the only thing that makes this great idea a bad idea is
> COMPATIBILITY CONCERNS; that's it.

Good... at last! But don't put ALL CAPS when you are in the wrong,
mate. And wasting a lot of people's time.



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
