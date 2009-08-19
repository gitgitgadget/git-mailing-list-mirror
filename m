From: "Rob (gmail)" <robvanb@gmail.com>
Subject: Re: New to Git / Questions about single user / multiple projects
Date: Wed, 19 Aug 2009 08:28:04 -0400
Message-ID: <a2db4dd50908190528o7f16b65are1acc89c900f7014@mail.gmail.com>
References: <a2db4dd50908181852s1e2c64fen8b883faf76b3136d@mail.gmail.com> 
	<m3ab1wnsie.fsf@localhost.localdomain> <a2db4dd50908190400x1cbb1506sa38c60e31587f49d@mail.gmail.com> 
	<200908191418.08838.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 14:28:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdkHK-0008Uo-VT
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 14:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbZHSM21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 08:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbZHSM20
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 08:28:26 -0400
Received: from mail-yw0-f173.google.com ([209.85.211.173]:38209 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbZHSM20 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 08:28:26 -0400
Received: by ywh3 with SMTP id 3so6131098ywh.22
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 05:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=bq51dDc2uOcULTQEOZQO1dWbKkK7R375mnBnuLD9TrA=;
        b=RiYPrisD8JW5+n0rspISUh7bfxzbK6BL9N1teXbTwCUp/t3gOTxynVFJ22JdPcL/EK
         /c+YpcpusrcGBi0eKvou2zUqzmUsV+V1+sQFz45vSJQe0KC1ldEYBCG0qdHisEExI3l0
         3tH6cdxVEBZQDXYZE2fklU09aZ2aOhfHG6P7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=EJWWy14HhZCkoeYYosZURNVZ1EIXCIrAHwq+Io93WTRgj7ojMzpEAwsFgxGOzhA6Eg
         uhOfyYBEmoNPwMjV4n7opfqG2CFFlxkRXwxKZVcNj8i905HZIUfm96vGjGsIjzjGJ0Fw
         /N3J5LL0PRqx7vbxIloiVUjlw7kPBfqknbMcY=
Received: by 10.150.32.17 with SMTP id f17mr10305208ybf.75.1250684906747; Wed, 
	19 Aug 2009 05:28:26 -0700 (PDT)
In-Reply-To: <200908191418.08838.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126537>

On Wed, Aug 19, 2009 at 8:18 AM, Jakub Narebski<jnareb@gmail.com> wrote:
> Please do not toppost, and when responding cull the quoted part,
> so only those parts that are relevant to your reply are remaining.

Sorry, n00b mistake.

> BTW. you can
> use different identities for different projects by setting it
> in .git/config, i.e. in per-repository configuration file.

That seems like the best solution.
How do I delete my initial repository that I created and obviously messed up ?
