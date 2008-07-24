From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2008
Date: Thu, 24 Jul 2008 16:07:06 +0200
Message-ID: <200807241607.07540.jnareb@gmail.com>
References: <200807230325.04184.jnareb@gmail.com> <7vsku1gqny.fsf@gitster.siamese.dyndns.org> <48886B8F.6000304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 16:08:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM1UT-0003ZI-CQ
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 16:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbYGXOHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 10:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbYGXOHU
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 10:07:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:43763 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbYGXOHS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 10:07:18 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1077895nfc.21
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 07:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Ha6Gvf2mkkdME0FwT8xLM+hruNj4LtXZPf0gpF40ZFI=;
        b=jZkhJk1qPJLF6NXdW0b7L71RNhD2+4910zNeWWEQDvSyJqMIY1OdEOoH2ATrdiKYHM
         YtYkxf868nztA7Nms6cNsAZjEPMnaOVI76WFIfsCPf9Ke0cx56+Bq2KHjV3rQZZR+grV
         zm2FqFfBYi0FI2JjnbhdG6o6r17XjpnK+41Z0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=tT2GlpEuQz4XkJsToVVurI4Pg8AVDkmLq2EIja9bdSWXheh7kkKdB6f7RcQ8RKSC0Q
         yONwHKUGx8pFYVlvSvXqYbEsTK//9Sh+c7aRF5OKOYG7onnxIITVi+xJPqUg4uxt9xK3
         OM0lUQglyNgHTwKCZUIBCJkAPQy0JVi0DMQak=
Received: by 10.210.91.17 with SMTP id o17mr366266ebb.172.1216908436801;
        Thu, 24 Jul 2008 07:07:16 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.208.47])
        by mx.google.com with ESMTPS id f4sm27567509nfh.27.2008.07.24.07.07.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Jul 2008 07:07:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48886B8F.6000304@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89883>

On Tue, 24 July 2008, Marek Zawirski wrote:
> Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>> (...)
>>   
>>>    27. Which of the following features do you use?
>>>        (zero or more: multiple choice)
>>>      - git-gui or other commit tool, gitk or other history viewer, patch
>>>        management interface (e.g. StGIT), bundle, eol conversion,
>>>        gitattributes, submodules, separate worktree, reflog, stash,
>>>        shallow clone, detaching HEAD, mergetool, interactive rebase,
>>>        add --interactive or other partial commit helper, commit
>>>        templates, bisect, other (not mentioned here)
>>>     
> I've got lost a little bit in this discussion, but some question about 
> used GUI for Git maybe interesting - the above one is touching the 
> problem. Just egit is missing there.

Actually jgit is in the list of possible choices for the following
question:
    16. Which porcelains / interfaces / implementations do you use?

But you have remind me about one feature that is missing from the 27.
list, namely "integration with IDE/editor" (I mean here things like
egit for Eclipse, future KDevelop DVCS integration, future Anjuta
Git integration, git.el or DVC for Emacs, plugin for TextMate, etc.)

-- 
Jakub Narebski
Poland
