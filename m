From: Heinrich Nirschl <heinrich.nirschl@gmail.com>
Subject: Re: Show current SHA1
Date: Sat, 11 Jul 2009 13:36:52 +0200
Message-ID: <394ab6ec0907110436o42062d7dn362194978bc098f9@mail.gmail.com>
References: <9586f3420907110239nbc35aealb473e1f1b3667410@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Allan Kelly <allankelly@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 13:37:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPat4-0008P8-Ll
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 13:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232AbZGKLgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2009 07:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753001AbZGKLgz
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 07:36:55 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:35807 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871AbZGKLgy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2009 07:36:54 -0400
Received: by fxm18 with SMTP id 18so1364381fxm.37
        for <git@vger.kernel.org>; Sat, 11 Jul 2009 04:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VOMMxJPbGKwtL+esu8DcSuGDbjvd9hkKmnacKj+fqm8=;
        b=kZrtIyWrQWBZ6NQeQ0fYMt/YO9c01YPGlJtqsmXwX4OOaE/tLlUgUUfRTiFGJiXRWM
         UyHHR5ScJ3v4aFUjT/BkQ1HtMqSAAi6Ae5FODXTQBI+EGoQMCQ+ue+w2xI8nQFUidOg/
         rCwt+me9q0F37/zX63zb1htB+/TgIlvm9We6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Jzlm62JcxXSAReV1wOXe9kZvmTEjwiPM89Ue9QeqDae9tfCS8inihBXAjcuxdr7fhD
         hAQxvCGjXszygR/SuwkBiICcsTEsp7eMuiyiNmAGqu2esilQmzT3wrygqCEiCS0SFFzK
         OYIvOgjc8OgtVSk6XHz8iWLwdkUnwkQPtlBnE=
Received: by 10.204.59.76 with SMTP id k12mr2880162bkh.136.1247312212848; Sat, 
	11 Jul 2009 04:36:52 -0700 (PDT)
In-Reply-To: <9586f3420907110239nbc35aealb473e1f1b3667410@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123110>

On Sat, Jul 11, 2009 at 11:39 AM, Allan Kelly<allankelly@gmail.com> wrote:
> I'd like to put the current SHA1 as text in the RTF so that I can
> generate a diff from my current version before responding to his
> comments.

Instead of doing that, you can put a tag on the version you deliver.

- Henry
