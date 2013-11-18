From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] RelNotes: Spelling & grammar fixes.
Date: Mon, 18 Nov 2013 12:00:10 -0800
Message-ID: <20131118200010.GJ27781@google.com>
References: <xmqqsiuzdhov.fsf@gitster.dls.corp.google.com>
 <1384448473-25840-1-git-send-email-marcnarc@xiplink.com>
 <xmqqmwl1blg7.fsf@gitster.dls.corp.google.com>
 <528A7016.7020307@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Nov 18 21:00:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViUze-0007CF-B0
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 21:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730Ab3KRUAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 15:00:18 -0500
Received: from mail-gg0-f174.google.com ([209.85.161.174]:57176 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544Ab3KRUAR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 15:00:17 -0500
Received: by mail-gg0-f174.google.com with SMTP id q3so2997812gge.19
        for <git@vger.kernel.org>; Mon, 18 Nov 2013 12:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ceJ1Umka7zuAAjKolb87aefQIeUJCkbqjn1Ssneu62o=;
        b=jWfWTBP8g5e6Sh8YW8czQcQQaMIRKHGb0ndoDHq07litPnKucDfoVlc2k5REsTKuqh
         nO8fCdxDWwcguJ1lTLfI70d35QuvuVRfcbDf9Ow4Y9pBWNZvBGl+dbq7OQMkp0M2vBnM
         58pwKhzzDOApOpg6yPJzqqKhuTBVUssKGphAy+AYC47AsHbLzC0C8Yper7yetmJ1bNu9
         t1HG9SOb1XMzQ87ka2ZkIT6kkCunkIhXAWHxXXQT2lu5hl3MD3v4x7kmBa/Xxa3+eFhX
         iC9Y6vpRJEiiYJGXRbGWGlIo1+zHrl/WI8rRGsQ9AUrFfuNhccaT1p4v+xQPGsamtCqu
         kO3g==
X-Received: by 10.236.228.137 with SMTP id f9mr18978318yhq.44.1384804813394;
        Mon, 18 Nov 2013 12:00:13 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id e10sm29727543yhj.1.2013.11.18.12.00.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 18 Nov 2013 12:00:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <528A7016.7020307@xiplink.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238012>

Marc Branchaud wrote:

>  * "git branch -v -v" (and "git status") did not distinguish among a
>    branch that is not based on any upstream branch, a branch that is in
>    sync with its upstream branch, and a branch that is configured with an
>    upstream branch that no longer exists.

Ooh, this is much nicer than the wording I suggested.

Thank you.
