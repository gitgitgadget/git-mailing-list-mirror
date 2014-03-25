From: Adam <adam@sigterm.info>
Subject: RE: What's cooking in git.git (Mar 2014, #05; Mon, 24)
Date: Tue, 25 Mar 2014 08:47:17 -0400
Message-ID: <000001cf4828$5b5f55e0$121e01a0$@info>
References: <xmqqr45rpcjm.fsf@gitster.dls.corp.google.com> <533161F7.5010508@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Michael Haggerty'" <mhagger@alum.mit.edu>,
	"'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 13:47:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSQlV-0002L3-Oa
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 13:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588AbaCYMr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 08:47:26 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:51749 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbaCYMrW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 08:47:22 -0400
Received: by mail-yh0-f47.google.com with SMTP id 29so347197yhl.34
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 05:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-type:content-transfer-encoding
         :thread-index:content-language;
        bh=HflYVf6f61TKp+Nds6w+ZB3jRr68dRRZGhj/32bVe3c=;
        b=Tw3guNHngu7MSIIwpIdvrBgjNgCOVtcYbF/yG4wVJUiWjgk12zuUJnruWu5vW1sJxm
         GWNgDWFg9yiuJnNw7szH6oEd4mO5kCxYJu8qLoVHVRLpOAMx2oOKYDRxgC7oCuXc63qs
         6+avoSvCVMnQNmOwhxe4PBZoieoapvmKYB7vnb/D8SCZJOMkxZj3fyNkWtgqSrepRn6q
         L40dMxPBSYpAq7roCCNl1G3WjUwZn9p2zy0xa1cpIbAjkf58lKb+AJv38stQSHJt0RHO
         QUGiElSk0zaNOp8hiEfKDAqHNPWjaHzgYviGY10XIvpX5Y6z04WlpycM9nsfZLUlA80J
         7c1Q==
X-Gm-Message-State: ALoCoQkA1zcakE/gaO/TOvDD13h5GDUWsNgt0mNicXtILOyS7h7HW66aGIFK/bCcQBuhIpuK8f6C
X-Received: by 10.236.151.83 with SMTP id a59mr41019926yhk.48.1395751641547;
        Tue, 25 Mar 2014 05:47:21 -0700 (PDT)
Received: from E520 ([97.102.54.5])
        by mx.google.com with ESMTPSA id x61sm4601587yhm.22.2014.03.25.05.47.19
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Mar 2014 05:47:20 -0700 (PDT)
In-Reply-To: <533161F7.5010508@alum.mit.edu>
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: Ac9IGYr5IshlGFfBQMmVyRqwezZokgADSVyw
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245029>

Michael wrote:
> The Signed-off-by line in this commit shows the name as only "Adam".
> Adam, unless this is your full name, please add a S-o-b line with your
> full name as per Documentation/SubmittingPatches.  This is important to
> help us track the provenance of all code in Git.

I'm sorry, I really would prefer not to use my full name, and I always use
'Adam' everywhere.

Adam
