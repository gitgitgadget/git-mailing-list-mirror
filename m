From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Re: [PATCH] Add git-annotate - a tool for annotating files with the revision and person that created each line in the file.
Date: Thu, 9 Feb 2006 13:04:54 +0100
Message-ID: <cda58cb80602090404o4e753839g@mail.gmail.com>
References: <11394103753694-git-send-email-ryan@michonline.com>
	 <cda58cb80602080835s38713193t@mail.gmail.com>
	 <86ek2dsn5f.fsf@blue.stonehenge.com> <43EB093A.1060207@op5.se>
	 <7vek2cetxh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 13:05:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7AXs-0006BY-2J
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 13:05:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422894AbWBIMEz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 07:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422896AbWBIMEz
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 07:04:55 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:65384 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422894AbWBIMEz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2006 07:04:55 -0500
Received: by zproxy.gmail.com with SMTP id 14so156634nzn
        for <git@vger.kernel.org>; Thu, 09 Feb 2006 04:04:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LimEsagjBlQOzEVAmDhfpuA1xfL/wc+F1BSAlnK41YCzxvV0J2TjXhu9q1uGLy9V267zH53w9pafz/pc+vJ7elzoGk++6Sp03jVgIDXHloew9kUpxqSoD74VKn1Yq4qnJzXmHMOB+B3RoTBAnPIke/fsP+uJcqDjEPRMWOD8Qpo=
Received: by 10.36.108.12 with SMTP id g12mr7257018nzc;
        Thu, 09 Feb 2006 04:04:54 -0800 (PST)
Received: by 10.36.49.12 with HTTP; Thu, 9 Feb 2006 04:04:54 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek2cetxh.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15809>

2006/2/9, Junio C Hamano <junkio@cox.net>:
> Andreas Ericsson <ae@op5.se> writes:
>
> > So long as we never involve ruby, java or DCL, I'm a happy fellow.
>
> Wholeheartedly seconded ;-).
>

I agree to but my point was more why not only using python scripts ?
Why sometimes some scripts is written in perl whereas python could be
used and vice-versa ?

Thanks
--
               Franck
