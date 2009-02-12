From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] stash: --keep option just saves
Date: Thu, 12 Feb 2009 17:28:23 +0900
Message-ID: <fc339e4a0902120028tdbad235xad7c38d504b89bc6@mail.gmail.com>
References: <20090212062514.6117@nanako3.lavabit.com>
	 <7vljscbp60.fsf@gitster.siamese.dyndns.org>
	 <buovdrgckpa.fsf@dhlpc061.dev.necel.com>
	 <20090212171742.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 09:30:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXWxd-0001jK-My
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 09:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757444AbZBLI23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 03:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbZBLI22
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 03:28:28 -0500
Received: from wf-out-1314.google.com ([209.85.200.174]:47078 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757415AbZBLI20 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 03:28:26 -0500
Received: by wf-out-1314.google.com with SMTP id 28so683285wfa.4
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 00:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=RrUx51RR7jsLqUdc0S0B2S0GRHGcxq5o3GBSY0RFGOU=;
        b=u4/4fN+u6bw9kpxWSOgJws5oDyV79MihMxqTInuvwJqG5prB/4syycah9oo6+9q9iT
         PzWL+bL9n+TrSGD7wLYTBE6MgxqYWpfvB1NVXFoASFqUMvo9h1N9fFsYmmQ6MuEg7C8Z
         kbx0Egh82bBD0tIZzAuuulTklpF4HRqLYZevo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=SNqiYWPkFlccCTXWNkAuTUTX1z/UQF6plfjYs+pqyP5VEkIC8UlD9b8YZR4UK4pnIC
         mK83oHfVuTnpM0zPYRLL8GjMUL5ubqtFNXx5VXJ76HyG7IjaX+mpm8BdSki3MUeoL36/
         utE/PqSuX3F+Mh/UsR8zbAm4knZRYhgJYjzuA=
Received: by 10.142.134.17 with SMTP id h17mr281360wfd.211.1234427303946; Thu, 
	12 Feb 2009 00:28:23 -0800 (PST)
In-Reply-To: <20090212171742.6117@nanako3.lavabit.com>
X-Google-Sender-Auth: 20061cc29397e14f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109585>

On Thu, Feb 12, 2009 at 5:17 PM, Nanako Shiraishi <nanako3@lavabit.com> wrote:
> I suspect you either didn't read or didn't understand the rest of Junio's message in which he explained why it isn't a good use of git.

See the final paragraph of my message.

-Miles

-- 
Do not taunt Happy Fun Ball.
