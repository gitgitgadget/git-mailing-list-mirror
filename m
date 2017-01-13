Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDB1320756
	for <e@80x24.org>; Fri, 13 Jan 2017 15:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752378AbdAMPXc (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 10:23:32 -0500
Received: from mout.gmx.net ([212.227.17.21]:53868 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752375AbdAMPX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 10:23:29 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MbOrg-1cBUkL2ZaG-00Imkn; Fri, 13
 Jan 2017 16:23:09 +0100
Date:   Fri, 13 Jan 2017 16:23:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Philip Oakley <philipoakley@iee.org>
cc:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] updates to gitk & git-gui doc now gitview has gone
In-Reply-To: <20170112213240.7972-1-philipoakley@iee.org>
Message-ID: <alpine.DEB.2.20.1701131622510.3469@virtualbox>
References: <20170112213240.7972-1-philipoakley@iee.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:SDHh87L8m2PuMcaSYMmaZsS5FFKPehc1BhdIq9cpX+uGMFdEtCc
 rsfREA6yeOD6iPVZiGPH6/BiKhfPk9NbNvW+EB722h2QEk6YsrfS4orwAoJiRsmNv3+ZaZ0
 x9LSNQU3d/XmkrfyMiWuaznKat5AdSABdXGoVX+xB+mXgmOG6RwkHLR/uJKkX/ZantbpN8F
 6FZ1c9Nemazdx+KgQJh8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FnQ+6rslU3Y=:jdx/sGNtPPmdN6GEgxUHgn
 y1ouX5MRLSOtF/0S71ZePKSuvF7CyekV4eK+sZ4HIdnK6QXZIGPQBg6HT23KcdROTYr3faaXK
 hTOpnVUYLJK7WbaQBMOYD77BLjaa2mDVmtaj5UqJ5/mt+q/B6rz7wYyvBBsZo22F3vN+6lsvq
 HpY4WvBbIzLdvnR4Yw75o3r3wmacgXdjfhwW0q/BNxTTgI/ceh/I6aMWD8Mne0s6TqamkdyFh
 ryjsMX4zgIsLFF/ORPV4/UtbWRHwz5bnmT/IuX9ZurYTaN9K73+aQGdPF88iF/d6V0Qm9xVMm
 QPPa3w79X1azCjlpnfxRr0hsUKfo4qxyBqoVY9zLVSptV6nt3Jfmo/7nvuDU14b7xPW5z1xq3
 T5LSXt7AISu39atmXWVFeK2wx/Yi34b4pzl9Vjt0aCVGfkiBdrxQ9BraUGL2zKUVeMiTEzhLj
 BKNjo8LtjBO1ZnIXDh4YCg4eQ0vELpOplqrcCUwYL7sJ8hHgVJAn/+2PVYgJl/c+7BmMe5uiI
 kOnRjjEmH30uDNNoe7pZpg0clmSGWFXtCTMkjyDPHpKsJ44LQ0pg2tJYWuAOFHerrwMzxCNsj
 JQ87sZSAB6XHsjn4VqBTX+gQcueeVcaC4AO9RWYUkyv29IVCHOwZ5TkzqQoOtPYvmRvn4/w8p
 P8DUdRGJhELGXBuNW4V5lWT+XIkU4Sxgxz+WY9/0FIgko3Sa8KKFbEY8W5mbQ8ZonAH203RRu
 T83L8Q5J5ii0OWwxrA9EeAE1vaoDSZvFVCJDuKqDjSdc+2ICAOT5ELAhFCZNQLIgG1s1l9zIR
 tLoOh3d825g1OOLja23s6bvIuozyWdi/KrpO02xf5/w/NyYgwYZCch2vtgyLq7UI9k8wWCwyo
 DOC64lLbLbA8c6+J5jhhoWprfZZPDMBlXE4IrhpJgpiFBL6o8HyGQ78tr2oCfRA4bzn7bZhJQ
 enNYYTDTlDysjneMXuNxDBwMa0w/AWEoHXWLLg/SN2uwN5d6NRxobn1tgUekVkatvFxYJMpQw
 d3PFN+q9FLF/sWEugF2Vwz1Kk1jbzmlYtmdfpc08ghiPzy4r+zFrE7YLBBFpzOw7lA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Thu, 12 Jan 2017, Philip Oakley wrote:

> gitview was removed recently.
> 
> > Sent: Tuesday, January 10, 2017 11:48 PM
> > Subject: What's cooking in git.git (Jan 2017, #01; Tue, 10)
> 
> > * sb/remove-gitview (2017-01-07) 1 commit
> >   (merged to 'next' on 2017-01-10 at dcb3abd146)
> >  + contrib: remove gitview
> 
> > Will merge to 'master'.
> 
> 
> Lets remove the reference in the gitk man page, and do some other
> fixups while in the area.

These changes all look sensible to me.

Ciao,
Dscho
