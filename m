From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 0/5] Extend pattern refspecs
Date: Fri, 6 Mar 2009 02:59:26 -0500
Message-ID: <76718490903052359r27153d01m468f61889ee2f196@mail.gmail.com>
References: <alpine.LNX.1.00.0903052346270.19665@iabervon.org>
	 <76718490903052119y4d6a7e0ck24bfeb1c0964e413@mail.gmail.com>
	 <alpine.LNX.1.00.0903060038510.19665@iabervon.org>
	 <76718490903052252y1778aa41g8f3e52329f7bf288@mail.gmail.com>
	 <alpine.LNX.1.00.0903060153490.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 09:00:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfUzJ-00059K-Mw
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 09:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbZCFH73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 02:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbZCFH73
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 02:59:29 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:38218 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbZCFH72 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 02:59:28 -0500
Received: by rv-out-0506.google.com with SMTP id g37so382879rvb.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 23:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JBasPYzDp5qdOFTkCCR4pX+aVdfI5sDYdIlyOr8l60g=;
        b=RQdBc5eyf8FomEtMFjNMsD/9fAPosoJKTc/zVoAmDHfZGJSPTSYJNIQelXeOwPrXQD
         KRLM1bbRB6mYnBi+74yImrLMt/+8ZZ3TbQ7mcrW4Lo33HAjjvqgQlWJPAF3eZExhe4b/
         7xZphnwWnFvMjA2lQpDbNJRLpemDwclk5Mvfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RNxLY2NHFLB1hIDYP3yH+xDghKc4EdkijexnZbDC+ndptpTz6yf/SkFVxkeu6xT0KI
         ZIKLUdvBA3qY3MRaPnu8h4DEfW6+yDAWQGQiQj4oXPuY3HbWeyw19uDadt5n5QwsdKDg
         GMKpCpD2RRM1X0RhEEC/glkShmbN5VR74H7Vo=
Received: by 10.140.141.16 with SMTP id o16mr1126261rvd.297.1236326366589; 
	Thu, 05 Mar 2009 23:59:26 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0903060153490.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112399>

On Fri, Mar 6, 2009 at 2:03 AM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> It'd be useful to have that message tested by your series, though, so I
> can verify my series reliably without worrying about whether I
> accidentally dropped both the fix and the test.

I'll send a patch for it in the next day or two.

j.
