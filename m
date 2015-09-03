From: Atul Sowani <sowani@gmail.com>
Subject: Re: git dockerfile.
Date: Thu, 3 Sep 2015 13:55:24 +0530
Message-ID: <CAAhzzTbtEr3NnJtXS4zrFmo8+Hm-2qt32XV=3UfWpZP+KFT2OQ@mail.gmail.com>
References: <CAAhzzTbvS_FewTC9Dz2XzOMXeKe405qHhvAGtcsVjXLK0kOehg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 10:25:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXPps-0000fD-Fa
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 10:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbbICIZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 04:25:27 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34502 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbbICIZY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 04:25:24 -0400
Received: by igcpb10 with SMTP id pb10so8903288igc.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 01:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=3Gwb/yREzzdtGQJoHC+88dqoRihWb+v/9E7w3fqGt9w=;
        b=C6wKfT75kJp4XvwzxM39Mbwi5dnknxWbqfr/02mE1xYqiPMdTnOj4PzlqlNRaXTkEt
         ZugeaqeP8gB+TFpkvbS08j3CpY/IupPzG338PL5lTLF6J9InU2PtDaehrb+iUitok0T4
         ZDxsj7ztqLaWo84H7YZDMRk7+hHeyyzlrw7B6VpQsKB8rRqcHYWfsxaAm7fhklTnhT4Y
         WDijKvFC5tLNFBb8+vy1WrzrrWlaVAFIJ65bLSiAaACtM751yzeo/yub15VCguVEeVyU
         E6kxc5BAgx8M9m0ZY63oUC8uHT0pXiBdKcEHEhIGr1+/kD7z9zHsra6vUZph3Ijberce
         9hDw==
X-Received: by 10.50.66.133 with SMTP id f5mr11300527igt.9.1441268724171; Thu,
 03 Sep 2015 01:25:24 -0700 (PDT)
Received: by 10.36.17.142 with HTTP; Thu, 3 Sep 2015 01:25:24 -0700 (PDT)
In-Reply-To: <CAAhzzTbvS_FewTC9Dz2XzOMXeKe405qHhvAGtcsVjXLK0kOehg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277186>

Hello!

Any help/pointers/advise regarding my request about dockerfile?

Thanks,
Atul.

On Tue, Sep 1, 2015 at 3:13 PM, Atul Sowani <sowani@gmail.com> wrote:
> Hi,
>
> Greetings everybody!
>
> I am looking for a Dockerfile for git which will _build_ git from source on
> ppc64le platform. I want to build git with different versions (say
> top-of-the-tree, latest-stable etc.) and it would be good if there is a
> dockerfile present alongwith the code which can build the source
> code with minimal changes (or better if there is a dockerfile
> available for each released version). This will avoid many incoherent
> copies of dockerfile floating around the Net.
>
> I tried to search on Internet but haven't come across any dockerfile
> which will build git source. I would highly appreciate if somebody
> could point me to a source where such dockerfile is available.
>
> I saw some communication on git mailing list, but so far haven't found
> any docker file. If there is no dockerfile available, I am willing to create
> one for ppc64le and commit it to git source. Please advise.
>
> Thanks,
> Atul.
