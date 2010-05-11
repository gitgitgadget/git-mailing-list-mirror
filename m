From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git branch descriptions
Date: Tue, 11 May 2010 12:54:26 +0000
Message-ID: <AANLkTimhCBNyJv6b9AT578AC4H1_zsB2CgfsrveNpNNE@mail.gmail.com>
References: <AcrwUP1AvzllIOBSQwuAO49egMRfdg==>
	 <657A681BEF27534399890012B8C8E50E1AD63D1FEA@lcs-exchange01.Lantekcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joel Reed <jreed@lantekcs.com>
X-From: git-owner@vger.kernel.org Tue May 11 14:59:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBp3H-0001HL-Er
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 14:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756626Ab0EKMy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 08:54:29 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59713 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756491Ab0EKMy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 08:54:28 -0400
Received: by fxm19 with SMTP id 19so380002fxm.19
        for <git@vger.kernel.org>; Tue, 11 May 2010 05:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=aVpPDkVppsWomveGvgRcrby1eL39jQfFmXEZSB3QVIw=;
        b=FdICQl4YxOFUM8bDbnIB19eBd5DAM2P+A9HbQMpQtUN/K43KrnhMWjD7mK+umwLSsv
         tNPkOxoKPnYumUDNaNeRlNT8Pon9MgIJ6Hv8rfw/PcNxn3i8n1k43GwqZxb0QOTNUa4I
         0GU8sj6dzOvcaIg5iFjfJrNLvojeKOT5jM/+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=B4iVmE8TMgtz0IJY5uXyCQWHxaTt+1MLFBoQtPfe45SAB68VGPHckZOj3vqOM3eEEt
         3fhlUPZlW8UONVIQoL3CHxa9+oqdNssuMQ0AeJn/oE7R6vrTS1ayJGodJGKqyDFMaB91
         ybSVIVHgBYOHXlT93Dprf0I8e0QEIt5jLuWlo=
Received: by 10.223.92.153 with SMTP id r25mr6218461fam.76.1273582466754; Tue, 
	11 May 2010 05:54:26 -0700 (PDT)
Received: by 10.223.109.78 with HTTP; Tue, 11 May 2010 05:54:26 -0700 (PDT)
In-Reply-To: <657A681BEF27534399890012B8C8E50E1AD63D1FEA@lcs-exchange01.Lantekcs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146891>

On Mon, May 10, 2010 at 14:56, Joel Reed <jreed@lantekcs.com> wrote:

> I like to keep branch names short so they're easy to switch to and
> from, but being able to attach a description that would display when
> doing a "git branch" would be a huge help.

Or you could just use long branch names coupled with bash completion
(or something like that) so it isn't hard to switch between branches
with long names.

I use branch names that are long enough so that I can tell what
they're for by looking at the name, using them isn't a pain due to
bash/magit completion.
