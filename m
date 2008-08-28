From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH] Add a reference to gitk localbranc remote/branch in gittutorial
Date: Thu, 28 Aug 2008 15:03:16 +0200
Message-ID: <4d8e3fd30808280603vc42de57kcfa03bcf02dd450f@mail.gmail.com>
References: <20080825215023.11822a20@paolo-desktop>
	 <loom.20080825T200956-169@post.gmane.org>
	 <7v63pog3rn.fsf@gitster.siamese.dyndns.org>
	 <4d8e3fd30808251512x126502bj5f154b58d7ae51a2@mail.gmail.com>
	 <7vy72kbov4.fsf@gitster.siamese.dyndns.org>
	 <4d8e3fd30808260116o543f1a61sd05070fe02f69d2e@mail.gmail.com>
	 <7viqtnabld.fsf@gitster.siamese.dyndns.org>
	 <4d8e3fd30808270058g3379174bn9efe09f550aa0721@mail.gmail.com>
	 <7v1w0aqqmj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Eric Raible" <raible@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 15:04:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYhAp-0002hY-F0
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 15:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209AbYH1NDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 09:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753130AbYH1NDS
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 09:03:18 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:56156 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917AbYH1NDR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 09:03:17 -0400
Received: by wf-out-1314.google.com with SMTP id 27so336587wfd.4
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 06:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=TCg4dmm5Mg2x7Fur78lFCwa+SKQO08U0etOA7m4yCJY=;
        b=xZYxKTMLHhRoDC3EO8VnGmOMZjNVSPCunkWBXcjdIRZkDBfDA2KgISBWntUOLXloHv
         smGhS0mvfiD1x7zdH4mxhK3AHQ4/cCNXEEC8a75nPkI58ZXCfntDDl3d2gqZGMcU1U0+
         0XJ8tl0JR6pKH25zwgZng3BWgpXeD1ru+hFpc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=U0Lc68XKkcvJr30627opT1H3BX5K0eYbxC/Phj5jgOsG98EkaHXp6QdXYGMAG5yjI9
         kkfHMNZJ1DZZhZCQ51jKyTIrlgsXGe2hGjghWs/IRx9D5SfR+R74s50AZwNkUR9qNMn5
         T5a8zEAUiSCX7Mwx1O5qiix3OHao6DK8yb5Nc=
Received: by 10.142.188.4 with SMTP id l4mr457695wff.151.1219928596434;
        Thu, 28 Aug 2008 06:03:16 -0700 (PDT)
Received: by 10.142.177.15 with HTTP; Thu, 28 Aug 2008 06:03:16 -0700 (PDT)
In-Reply-To: <7v1w0aqqmj.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94047>

On Wed, Aug 27, 2008 at 8:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> diff --git a/gittutorial.txt.txt b/gittutorial.txt.txt
>> index 48d1454..384972c 100644
>> --- a/gittutorial.txt.txt
>> +++ b/gittutorial.txt.txt
>
> I have to wonder why txt.txt, though.

Eheh, patch done on WinXP machine not
properly set up...

Regards,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
