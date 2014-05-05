From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: material for git training sessions/presentations
Date: Sun, 04 May 2014 23:53:57 -0500
Message-ID: <53671965621e_25b273930894@nysa.notmuch>
References: <CAFOYHZDNkTpQVge8Z_qOPS3eH-afKs-KeaFsQ6sOCtLbGgjdbQ@mail.gmail.com>
 <CAP2yMa+Q56R_Rsbsy4siJNKy0wU0JN7QM1NPMBO8sO_E9CSMwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, training@github.com
To: Scott Chacon <schacon@gmail.com>,
	Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 18:24:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whhsn-0005Yp-L1
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555AbaEEFEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 01:04:39 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:49449 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754550AbaEEFEj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 01:04:39 -0400
Received: by mail-oa0-f52.google.com with SMTP id o6so897640oag.25
        for <git@vger.kernel.org>; Sun, 04 May 2014 22:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=MfgfiYxkXa4i9xIxurCzA6UYXqDv0DNUYL/40q5co7U=;
        b=w0Qdrl4DJsp3h8arhtZ2Nh1MOt8ifTSrBgTpf/dWfDTWZghZFJQRwVopiw7bjH92tp
         D6QfQrVOegtSDRN+75cqvHlaxEzfG4BEtHxf5Vhn3pipCNyU2ckYMUJW5isE+7uWcRGx
         TYpp1/esgL40mi2RMFRbo4qqg/FqUjwYj7lKya/ouIaMPcdQ8vn+YnSfUzZw0FvIOOSQ
         OlscUHs6KX3qSUJ45R5dUTGBkceyKyvWh7OO/zKV3iysH6EZwAIFZUQUcOX6XSavonQP
         Lyc8Xv/ooP2TjkrslsHG9OFp96JAvP0GALCaxUhe3J+/o7ZGMHpsEuKnNdfSFE2nW7VM
         8UkQ==
X-Received: by 10.182.45.161 with SMTP id o1mr8849926obm.29.1399266278703;
        Sun, 04 May 2014 22:04:38 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id pt8sm16689339obb.5.2014.05.04.22.04.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 May 2014 22:04:37 -0700 (PDT)
In-Reply-To: <CAP2yMa+Q56R_Rsbsy4siJNKy0wU0JN7QM1NPMBO8sO_E9CSMwA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248134>

Scott Chacon wrote:
> The GitHub training team has all of their materials open sourced under
> a CC BY 3.0 license.  They're all written in Markdown and hosted on
> GitHub.  You can check them out here, including going through an
> online rendering of the materials:
> 
> http://training.github.com/kit/

Very nice!

I'm skimming through the contents and I noticed you mention
'color.ui = auto' a lot. There's no need for that, it has been the
default since v1.8.4.

Cheers.

-- 
Felipe Contreras
