From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] fixup! Documentation/git-commit.txt: rework the --cleanup section
Date: Tue, 19 Feb 2013 12:33:35 -0800
Message-ID: <CA+sFfMes8X4opKjz0nOrZagtnjTD=7-xf5XcrB6pZW3cBR-jqw@mail.gmail.com>
References: <7va9r06we2.fsf@alter.siamese.dyndns.org>
	<1361298570-19738-1-git-send-email-bcasey@nvidia.com>
	<20130219202822.GA13460@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Brandon Casey <bcasey@nvidia.com>, gitster@pobox.com,
	git@vger.kernel.org, ralf.thielow@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 21:34:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7tt4-0008OG-Ku
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 21:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758828Ab3BSUdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 15:33:38 -0500
Received: from mail-wi0-f182.google.com ([209.85.212.182]:57440 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758387Ab3BSUdi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 15:33:38 -0500
Received: by mail-wi0-f182.google.com with SMTP id hi18so5365120wib.9
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 12:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=hsl/vVSOAlFkxlK4SRx272/tlnfn4Buy8pc1HgvVIAU=;
        b=XzqADUeUOJJ6zcRd7bdCQZRv7N9FqAB4GZPLnVoVjcFa61NsKqtpqey2pa1kle+Edl
         Tbv4dyXjbE2fjgL9le5v9ztAju7r1gmLLhfBxVIllbTZqa8Z3q0+8c/TW+2u3ZW5V8a3
         yEpubhSXiqtwQUVCee66C7+EnceejZDCrRBsBXXtz61d9AtqZirFYLif5/mCP4D8PNlV
         qQA0W+QP6KgjaeMKr+J2B8SxIXHP/9SvLErpcCjoNAUkJywWq7LvK10LNv8jz/BHJCu/
         USsjIptif1TG3B4ZcJc9GZATUClxydTJJe7G1V1rVo8EUQYTHQe+2rYSUKHtXxuXx/TA
         JfYA==
X-Received: by 10.180.80.34 with SMTP id o2mr27562951wix.0.1361306015427; Tue,
 19 Feb 2013 12:33:35 -0800 (PST)
Received: by 10.194.63.46 with HTTP; Tue, 19 Feb 2013 12:33:35 -0800 (PST)
In-Reply-To: <20130219202822.GA13460@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216658>

On Tue, Feb 19, 2013 at 12:28 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Brandon Casey wrote:

> Problems:
>
>  * There's a weird extra blank line after "default"
>  * Wrong indentation for the final paragraph.
>  * The linkgit isn't resolved for some reason.
>
> The following fixes it for me.

Thanks Jonathan.

-Brandon
